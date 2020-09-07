#!/bin/bash

cd /home/www/website

if [ ! -d "go-home" ]; then
  git clone https://github.com/pingyeaa/go-home.git
fi

cd go-home
git pull