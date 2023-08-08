from fastapi import FastAPI, Request
import uvicorn
api = FastAPI()


@api.post("/webhook")
async def webhook_endpoint(request: Request):
    webhook_payload = await request.json()
    print(f"Received webhook for file {webhook_payload['file_name']}. Event: {webhook_payload['event']}")

if __name__ == '__main__':
    uvicorn.run(api, host='127.0.0.1', port=8081)