# RH-AI-STEM

## Pre-requisites on an empty MacOS
- Install brew:
	- /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
- Install pip, Cython, wget:
	- brew install pip
	- brew install wget
	- brew install python3
- Install virtualenv, Python3:
	- $ python3 -m venv ./venv
	- $ source ./venv/bin/activate
- Install Cython:
	- pip install Cython
	
## Setting up environments
- Run the command:
	- bash env.sh

## Traning Corgi models

- Traning:
	- $ cd models/research/object_detection
	- $ python model_main.py --logtostderr --model_dir=corgi_training/ --pipeline_config_path=corgi_training/corgi.config
- Export inference graph:
	- TODO: Looking for highest number of trained model in models/research/object_detection/corgi_training
	- $ python export_inference_graph.py --input_type image_tensor --pipeline_config_path corgi_training/corgi.config --trained_checkpoint_prefix corgi_training/model.ckpt-<highest_number> --output_directory inference_graph_corgi

## Run testing

- Copy testing script into tensorflow models:
	- $ cp corgi_detection.py models/research
- Run:
	- $ python models/research/corgi_detection.py

## Notes:

- Change the backend of matplotlib in corgi_detection.py to a relevant one of running machine in order to using matplotlib for image rendering
