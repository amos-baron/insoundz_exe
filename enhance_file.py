import argparse
import queue

import numpy as np
import tensorflow as tf
from multiprocessing import Process, Queue, cpu_count,active_children
from waiting import wait
from collections import defaultdict
from threading import Thread,Event
import logging
import atexit
import sys

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


class AudioEnhancer:
    def __init__(self, model_path: str, num_processes: int = None, num_threads: int = 1):
        self.model_path = model_path
        self.num_processes = num_processes or cpu_count()
        self.unprocessed_frames_queue = Queue()
        self.processed_frames_queue = Queue()
        self.sid_to_frames = defaultdict(list)
        self._create_processes(self.num_processes)
        self.num_threads = num_threads
        self.stop_thread = Event()
        self._create_threads(self.num_threads)
        logging.info("AudioEnhancer initialized.")

    def terminate(self):
        logging.info("Terminating processes")

        active_child_processes = active_children()
        for child_process in active_child_processes:
            logging.info(f"Terminating child process: {child_process.name}")
            child_process.terminate()
            child_process.join()  # Wait for the child process to finish
        logging.info(f"Terminated all child processes")
        self.stop_thread.set()
        logging.info(f"stopped threads")


    def _process_audio_frame(self):
        model = self.load_tflite_model(self.model_path)

        # Get model input details
        input_shape = model.get_input_details()[0]['shape']

        while True:
            # Get unprocessed frame
            index, frame, session_id = self.unprocessed_frames_queue.get()
            # Reshape frame into input format
            frame = frame.reshape(input_shape)
            input_details = model.get_input_details()
            output_details = model.get_output_details()

            # Enhance frame with model
            model.set_tensor(input_details[0]['index'], frame)
            model.invoke()
            enhanced_frame = model.get_tensor(output_details[0]['index'])
            self.processed_frames_queue.put((index, enhanced_frame, session_id))

    def _sort_frames_by_sid(self):
        while not self.stop_thread.is_set():
            try:
                frame_idx, enhanced_frame, session_id = self.processed_frames_queue.get(timeout=1)
                self.sid_to_frames[session_id].append((frame_idx, enhanced_frame))
            except queue.Empty:
                pass

    def _create_threads(self, num_threads):
        # Create n threads that are continuously sorting processed frames
        self.stop_thread.clear()
        for _ in range(num_threads):
            t = Thread(target=self._sort_frames_by_sid)
            t.start()

    def _create_processes(self, num_processes: int):
        # Create n processes that are continuously processing frames
        for _ in range(num_processes):
            p = Process(target=self._process_audio_frame)
            p.start()

    def load_tflite_model(self, model_path):
        interpreter = tf.lite.Interpreter(model_path=model_path)
        interpreter.allocate_tensors()
        return interpreter

    def calculate_num_frames(self, audio_data: np.ndarray, frame_length) -> int:
        return len(audio_data) // frame_length

    def enhance_audio(self, audio_data: np.ndarray,
                      session_id: str = 'x', frame_length: int = 1024) -> np.ndarray:
        num_frames = self.calculate_num_frames(audio_data, frame_length)

        # Divide into frames and put in unprocessed frames queue for enhancing
        for i in range(num_frames):
            frame = audio_data[i * frame_length: (i + 1) * frame_length]
            # Store index and frame for later reconstruction of audio
            # Store session_id in case the class is processing multiple audio files simotaniously
            self.unprocessed_frames_queue.put((i, frame, session_id))
        # Collect the results from the result queue
        enhanced_audio = np.empty_like(audio_data)
        wait(lambda: len(self.sid_to_frames[session_id]) == num_frames, timeout_seconds=120,
             waiting_for="something to be ready")

        for index, enhanced_frame in self.sid_to_frames[session_id]:
            frame_start = index * frame_length
            frame_end = (index + 1) * frame_length
            enhanced_audio[frame_start:frame_end] = enhanced_frame.squeeze()

        return enhanced_audio


def main() -> None:
    parser = argparse.ArgumentParser(description='Audio Enhancement using TFLite model')
    parser.add_argument('--source-file', type=str, required=True, help='Path to the source audio file')
    parser.add_argument('--destination-file', type=str, required=True,
                        help='Path to the destination enhanced audio file')
    parser.add_argument('--model-path', type=str, required=True, help='Path to the TFLite model')
    parser.add_argument('--num-processes', type=int, default=cpu_count(),
                        help='Number of processes to use for multiprocessing')
    parser.add_argument('--frame-length', type=int, default=1024, help='Frame length for audio processing')
    args = parser.parse_args()
    try:
        # Create the AudioEnhancer object
        enhancer = AudioEnhancer(args.model_path)

        # Load the audio file
        audio_data = load_audio_file(args.source_file)

        # Enhance the audio using multiprocessing
        enhanced_audio = enhancer.enhance_audio(audio_data=audio_data,
                                                frame_length=args.frame_length)

        # Save the enhanced audio to the destination file
        save_audio_file(args.destination_file, enhanced_audio)
    except FileNotFoundError as e:
        logging.error(f"File not found: {e.filename}")
    except PermissionError as e:
        logging.error(f"Permission error: {e}")
    except Exception as e:
        logging.error(f"An error occurred: {e}")
    finally:
        enhancer.terminate()
        sys.exit()


# Register a function to run at program exit
atexit.register(main)


def load_audio_file(filename: str) -> np.ndarray:
    with open(filename, 'rb') as f:
        audio_data = np.frombuffer(f.read(), dtype=np.float32)
    logging.info(f"File loaded: {filename}")
    return audio_data


def save_audio_file(filename: str, audio_data: np.ndarray) -> None:
    with open(filename, 'wb') as f:
        f.write(audio_data.tobytes())
    logging.info(f"File saved: {filename}")


if __name__ == "__main__":
    main()
