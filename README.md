# passthrough_model.py
  This file contains the model and if it is run as a script the model will be saved inside the same dir inside passthrough_model. 
  ##### run it with #####
  ```python passthrough_model.py```
# tfl_model_exporter.py 
  This file contains a function export_to_tflite that recieves a saved_model_path and a destination path and exports the model to tensorflowlite.
  
  by default it saves it to "passthrough_model_lite.tflite" the saved_model_path should be the same as the path where "passthrough_model.py" saves the model.

  ##### run it with #####
  ```python tfl_model_exporter.py```
    
# enhance_file.py 
 This file can act as a script that accepts Arguments and also contains a class that can be imported and used in other modules 
 ## Run it as script ##
  - to run it as a script you should use the Terminal with the requiered flags
  *  for example if you are in the root directory of the repo:
    ##### run it with #####
   ```python models/enhance_file.py --source-file audio_samples/audio_file_48k.raw --destination-file enhanced_audio.raw --model-path models/passthrough_model_lite.tflite``` 

## Farther explanation on how it works ##
  ### AudioEnhancer class ### 
  - each instance of a class spawns X processes (cpu_count by default) that are continuously trying to fetch frames from an unprocessed frame queue 
  - once they fetch an unprocessed frame from the queue they process it with the model
  - after they have processed the frame they push it into a processed frames queue
  - the class instance also spawns Y threads (by default 1 as its not labour intensive) 
  - each thread  trys to fetch processed_frames from the processed_frames_queue continuously
  - once it fetches the frame it sorts it into a list using a session_id
  ##### in the future we might want to implement a PriorityQueue for the processed_frames and unprocessed_frames queues for optimization 
  #### process_audio method ####
  - the class has a method named process_audio
  - it gets a session_id and an unprocessed_audio
  - seperates it into frames of correct size for model
  - pushes the frames into unprocessed_frames queue
  - waits until all frames are processed
  - reconstructs audio and returns it
# main.py 
  This file contains the login for the RESTfull api that recieves POST requests to enhance file, you should download requierments from the requierments.txt file.
    ##### run it with #####
      ```python main.py```

  After that you can go to "http://127.0.0.1:8080/docs" for more documentation on how to interact with the api 


# test_api.py 
unittests for correct basic input validation of the api, we can also use "http://127.0.0.1:8080/docs".
  ##### run it with #####
      ```python test_api.py```


   
