#!/bin/bash

currentPath=$(pwd)
configFile=$currentPath/corgi.config
sed -i '' "s?corgi_path?$currentPath?" $configFile

