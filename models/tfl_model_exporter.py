import tensorflow as tf

def export_to_tflite(saved_model_path, tflite_model_path):
    # Convert the SavedModel to TFLite format
    converter = tf.lite.TFLiteConverter.from_saved_model(saved_model_path)
    tflite_model = converter.convert()

    # Save the TFLite model to a file
    with open(tflite_model_path, 'wb') as f:
        f.write(tflite_model)


if __name__ == "__main__":
    # Call the function to export the model to TFLite
    export_to_tflite('passthrough_model', 'passthrough_model_lite.tflite')
