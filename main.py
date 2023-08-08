from fastapi import FastAPI, HTTPException
from fastapi.responses import JSONResponse
from starlette.requests import Request
from settings import settings
from enhance_file import AudioEnhancer, load_audio_file, save_audio_file
from api_models.models import EnhancementRequest, WebhookProcessingError
import uvicorn
import os
import requests
import uuid
import logging
from helpers.audio_manipulators import convert_to_required_format

APP_INTERFACE = settings.app_interface
APP_PORT = settings.app_port
MODEL_PATH = settings.tf_model_path
DESIRED_SAMPLE_RATE = 48000
app = FastAPI()

logging.config.fileConfig('logging.conf', disable_existing_loggers=False)

logger = logging.getLogger(__name__)


@app.post("/enhance-file")
async def enhance_file(enhancement_request: EnhancementRequest):
    source_path = enhancement_request.source_path
    output_path = enhancement_request.output_path
    webhook_url = enhancement_request.webhook_url
    original_sample_rate = enhancement_request.sample_rate.value

    if not os.path.exists(source_path):
        raise HTTPException(status_code=404, detail="Source file not found")
    try:
        audio_data = load_audio_file(filename=source_path)

        # Convert audio data to desired sample rate
        audio_data = convert_to_required_format(audio_data,DESIRED_SAMPLE_RATE,original_sample_rate)
        # Generate Session ID in order to multiprocess audiofiles
        session_id = str(uuid.uuid4())

        enhanced_audio = enhancer.enhance_audio(audio_data=audio_data, session_id=session_id)
        # Revert back to original sample rate
        enhanced_audio = convert_to_required_format(enhanced_audio,original_sample_rate,DESIRED_SAMPLE_RATE)

        save_audio_file(filename=output_path, audio_data=enhanced_audio)
        send_webhook(webhook_url, os.path.basename(source_path), "success")

    except requests.exceptions.ConnectionError:
        # Raise costume Exception for future tailored handling
        raise WebhookProcessingError(webhook_url=webhook_url,original_exception='Webhook timeout bad gateway')
    except Exception as e:
        logger.info(f"Error enhancing file {source_path}")
        send_webhook(webhook_url, os.path.basename(source_path), "exception")
        raise HTTPException(status_code=500, detail="Error enhancing file")


@app.exception_handler(WebhookProcessingError)
async def timeout_webhook_exception_handler(request: Request, exc: WebhookProcessingError):
    logger.info(f"Failed to send webhook to {exc.webhook_url} not responding")
    return JSONResponse(content={'error': f'timeout waiting for webhook {exc.webhook_url}'},
                        status_code=504)


@app.exception_handler(requests.exceptions.ConnectionError)
async def timeout_request_exception_handler(request: Request,
                                            exc: requests.exceptions.ConnectionError):
    logger.info(f"Timeout waiting for gateway not responding")
    return JSONResponse(content={'error': 'timeout waiting for gateway'},
                        status_code=504)


def send_webhook(webhook_url, file_name, event):
    payload = {"file_name": file_name, "event": event}
    requests.post(webhook_url, json=payload)


if __name__ == '__main__':
    # Initialize the Enhancer module only when run as script
    enhancer = AudioEnhancer(MODEL_PATH)
    # Run app
    uvicorn.run(app, host=APP_INTERFACE, port=APP_PORT)
