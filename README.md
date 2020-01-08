# RH-AI-STEM

## Pre-requisites

- Install virtualenv, Python3:
	- TODO: Install Python3, git
	- $ python3 -m venv ./venv
	- $ source ./venv/bin/activate
- Install following packages:
	- $ pip install --user Cython
	- $ pip install --user contextlib2
	- $ pip install --user pillow
	- $ pip install --user lxml
	- $ pip install --user matplotlib
- Install tensorflow 1.14:
	- $ pip install tensorflow==1.14

## Setting up environments

- TODO: Download protoc
- TODO: Download tensorflow/models
- Creating python files from proto files:
	- $ cd models/research
	- $ <path_to_protoc> object_detection/protos/*.proto --python_out=.
- Add paths to environment variables:
	- $ export PYTHONPATH=$PYTHONPATH:$(pwd)/models/research
	- $ export PYTHONPATH=$PYTHONPATH:$(pwd)/models/research/object_detection
	- $ export PYTHONPATH=$PYTHONPATH:$(pwd)/models/research/slim
- Place cocoapi into models/research:
	- $ git clone https://github.com/cocodataset/cocoapi.git
	- $ cd cocoapi/PythonAPI
	- $ make
	- $ cp -r pycocotools $(pwd)/models/research/
- Install object detection API:
	- $ cd models/research
	- $ python setup.py build
	- $ python setup.py install
- Create corgi_training folder:
	- $ mkdir models/research/object_detection/corgi_training
- Copy corgi.config and corgi.pbtxt into corgi_training:
	- $ cp corgi.config corgi.pbtxt models/research/object_detection/corgi_training

## Traning Corgi models

- Traning:
	- $ cd models/research/object_detection
	- $ python model_main.py --logtostderr --model_dir=corgi_training/ --pipeline_config_path=corgi_training/corgi.config
- Export inference graph:
	- TODO: Looking for highest number of trained model in models/research/object_detection/corgi_training
	- $ python export_inference_graph.py --input_type image_tensor --pipeline_config_path corgi_training/corgi.config --trained_checkpoint_prefix corgi_training/model.ckpt-<highest_number> --output_directory inference_graph_corgi

## Run testing

- Run:
	- $ python corgi_detection.py

## NOTES:

- Change the backend of matplotlib in corgi_detection.py to a relevant one of running machine in order to using matplotlib for image rendering
