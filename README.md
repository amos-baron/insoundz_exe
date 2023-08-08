# passthrough_model.py
  This file contains the model and if it is run as a script the model will be saved inside the same dir inside passthrough_model. 
     ```python passthrough_model.py```
# tfl_model_exporter.py 
  This file contains a function export_to_tflite that recieves a saved_model_path and a destination path and exports the model to tensorflowlite.
  
  by default it saves it to passthrough_model_lite.tflite the saved_model_path should be the same as the path where "passthrough_model.py" saves the model.
    ```python tfl_model_exporter.py```
# enhance_file.py 
 This file can act as a script that accepts Arguments and also contains a class that can be imported and used in other modules 
  - to run it as a script you should use the Terminal with the requiered flags
  *  for example if you are in the root directory of the repo:
  
   ```python models/enhance_file.py --source-file audio_samples/audio_file_48k.raw --destination-file enhanced_audio.raw --model-path models/passthrough_model_lite.tflite``` 
# main.py 
  This file contains the login for the RESTfull api that recieves POST requests to enhance file, you should download requierments from the requierments.txt file and run it with:
      ```python main.py```

  After that you can go to "http://127.0.0.1:8080/docs" for more documentation on how to interact with the api 

   
