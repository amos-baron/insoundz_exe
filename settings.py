from pydantic_settings import BaseSettings
from pydantic import Field

class Settings(BaseSettings):
    app_interface: str = Field("127.0.0.1", env="APP_INTERFACE")
    app_port: int = Field(8080, env="APP_PORT")
    tf_model_path: str = Field('models/passthrough_model_lite.tflite',env='TF_MODEL_PATH')
    desired_sample_rate: int = Field(48000,env='DESIRED_SAMPLE_RATE')

settings = Settings()
