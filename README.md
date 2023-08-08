# Insoundz Home Assignment

## Files and Modules Overview

1. **passthrough_model.py**: This script defines a machine learning model that plays a role in audio enhancement. When executed as a standalone script, the model is saved within the same directory. 

2. **tfl_model_exporter.py**: In this script, the `export_to_tflite` function is implemented. This function takes a saved model path and a destination path as input arguments. It's responsible for converting the saved model into the TensorFlow Lite format. By default, the exported model is saved as "passthrough_model_lite.tflite".

3. **enhance_file.py**: This  script serves both as a standalone executable and a reusable module. When executed as a script with appropriate command-line arguments, it harnesses the power of the model from `passthrough_model.py` to enhance audio files. Enhanced audio is saved to a user-specified destination. The script introduces an `AudioEnhancer` class, which efficiently processes audio frames and reconstructs enhanced audio. The `process_audio` method within this class is at the heart of the audio enhancement process.

    **Example Usage**:
    ```
    python enhance_file.py --source-file audio_samples/audio_file_48k.raw --destination-file enhanced_audio.raw --model-path models/passthrough_model_lite.tflite
    ```

4. **main.py**: This script forms the backbone of the project by implementing a RESTful API. Upon execution, it launches a local server ready to accept POST requests for audio file enhancement. Leveraging the capabilities of the `AudioEnhancer` class from `enhance_file.py` for further documentation go to [http://127.0.0.1:8080/docs](http://127.0.0.1:8080/docs)..

    **Example Usage**:
    ```
    python main.py
    ```

5. **test_api.py**: To ensure the robustness of the API, this script contains a suite of unit tests. These tests focus on validating the fundamental input validation aspects of the API. Alongside these tests, manual testing of the API can also be performed through the user-friendly interface at [http://127.0.0.1:8080/docs](http://127.0.0.1:8080/docs).

    **Example Usage**:
    ```
    python test_api.py
    ```

## AudioEnhancer Class 

The `AudioEnhancer` class is a core component of the project, designed to efficiently enhance audio files using the model, multiprocessing and queues. This design maximizes the utilization of system resources for concurrent audio frame processing.

### Multiprocessing:

Multiprocessing involves dividing the workload into multiple independent processes that can run simultaneously on different CPU cores. The `AudioEnhancer` class takes full advantage of this approach for efficient audio enhancement.

1. **Unprocessed Frame Queue (`unprocessed_frames_queue`)**: Audio files are divided into smaller frames suitable for model processing. These frames are pushed into the `unprocessed_frames_queue`. The `AudioEnhancer` class spawns multiple processes (usually equal to the number of CPU cores) that continuously fetch frames from this queue. This allows for parallel frame processing.

2. **Processed Frame Queue (`processed_frames_queue`)**: After each process completes enhancing a frame, the enhanced frame is pushed into the `processed_frames_queue`. This queue stores the enhanced frames in the order they were processed.


Within each individual process, multithreading is used to further optimize the processing efficiency.

**Sorting and Reconstructing**: Another set of threads (usually just one) is dedicated to fetching enhanced frames from the `processed_frames_queue`. These threads organize the frames based on session IDs. Each frame is associated with a session ID that helps order the frames correctly for reconstruction..

### Frame Processing and Audio Reconstruction:

1. **Processing**: As each thread within a process fetches an unprocessed frame, it sends that frame through the model to enhance it. The enhanced frame is then pushed into the `processed_frames_queue`.

2. **Reconstruction**: the **enhance_audio** function is responsible for seperating the audio into frames and pushing the frames into the  **Unprocessed Frame Queue (`unprocessed_frames_queue`)**, it gets the audio and a session_id as parameters

