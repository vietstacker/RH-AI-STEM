#!/bin/bash

# CorgiPath
corgiPath=$(pwd)

# Create virtualven
# python3 -m venv ./venv
# source ./venv/bin/activate

# Install following packages:
pip install --user contextlib2
pip install --user pillow
pip install --user lxml
pip install --user matplotlib
pip install --user Cython

# Install tensorflow 1.14:
pip install tensorflow==1.14

# Download protoc
wget https://github.com/protocolbuffers/protobuf/releases/download/v3.11.2/protoc-3.11.2-osx-x86_64.zip
unzip protoc-3.11.2-osx-x86_64.zip -d protoc

# Download tensorflow/models
git clone https://github.com/tensorflow/models.git
cd models/research && ../../protoc/bin/protoc object_detection/protos/*.proto --python_out=.
cd ../..

# Add paths to environment variables:
export PYTHONPATH=$PYTHONPATH:$(pwd)/models/research
export PYTHONPATH=$PYTHONPATH:$(pwd)/models/research/object_detection
export PYTHONPATH=$PYTHONPATH:$(pwd)/models/research/slim

# Place cocoapi into models/research:
git clone https://github.com/cocodataset/cocoapi.git
cd cocoapi/PythonAPI && make
cp -r pycocotools $corgiPath/models/research/
cd ../..

# Install object detection API:
cd models/research && python setup.py build && python setup.py install
cd ../..

# Update corgi path to configfile
configFile=$corgiPath/corgi.config
sed -i '' "s?corgi_path?$corgiPath?" $configFile

# Create corgi_training folder:
mkdir models/research/object_detection/corgi_training
# Copy corgi.config and corgi.pbtxt into corgi_training:
cp corgi.config corgi.pbtxt models/research/object_detection/corgi_training

# Copy running script:
cp corgi_detection.py models/research
