from pydantic import BaseModel,Field, validator
from enum import Enum
from urllib.parse import urlparse


class SampleRate(Enum):
    SR_48000 = 48000
    SR_32000 = 32000
    SR_16000 = 16000


class EnhancementRequest(BaseModel):
    source_path: str = Field(..., description="Path to the source audio file")
    output_path: str = Field(..., description="Path to save the enhanced audio file")
    webhook_url: str = Field(..., description="URL for the webhook")
    sample_rate: SampleRate = Field(default=SampleRate.SR_48000,
                                    description="Optional audio sample rate. Defaults to 48000.")

    # Custom validator for webhook_url to ensure it is a valid URL
    @validator('webhook_url')
    def validate_webhook_url(cls, value):
        if not cls.is_valid_url(value):
            raise ValueError("Invalid webhook URL")
        return value

    @classmethod
    def is_valid_url(cls, url):
        parsed_url = urlparse(url)
        return parsed_url.scheme and parsed_url.netloc


class WebhookProcessingError(Exception):
    def __init__(self, webhook_url, original_exception):
        self.webhook_url = webhook_url
        self.original_exception = original_exception
        super().__init__(f'An error occurred while processing the webhook URL "{webhook_url}": {str(original_exception)}')

