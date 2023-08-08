import unittest
from fastapi.testclient import TestClient
from main import app

TEST_WEBHOOK_SERVER_URL = 'http://127.0.0.1:8081/webhook'
VALID_AUDIO_SAMPLE = "audio_samples/audio_file_48k.raw"
VALID_AUDIO_OUTPUT = "audio_samples/enhanced_audio_file.raw"

class TestApp(unittest.TestCase):
    def setUp(self):
        self.client = TestClient(app)

    def test_bad_webhook_url(self):
        payload = {
            "source_path": VALID_AUDIO_SAMPLE,
            "output_path": VALID_AUDIO_OUTPUT,
            "webhook_url": "badurl",  # Bad URL
            "sample_rate": 48000
        }
        response = self.client.post("/enhance-file", json=payload)
        self.assertEqual(response.status_code, 422)

    def test_bad_paths(self):
        payload = {
            "source_path": "nonexistent_source_path",  # Bad path
            "output_path": VALID_AUDIO_OUTPUT,
            "webhook_url": TEST_WEBHOOK_SERVER_URL,
            "sample_rate": 48000
        }
        response = self.client.post("/enhance-file", json=payload)
        self.assertEqual(response.status_code, 404)

    def test_bad_sample_rate(self):
        payload = {
            "source_path": VALID_AUDIO_SAMPLE,
            "output_path": VALID_AUDIO_OUTPUT,
            "webhook_url": TEST_WEBHOOK_SERVER_URL,
            "sample_rate": "invalid_sample_rate"  # Bad sample rate
        }
        response = self.client.post("/enhance-file", json=payload)
        self.assertEqual(response.status_code, 422)

if __name__ == "__main__":
    unittest.main()
