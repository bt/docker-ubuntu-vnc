#!/bin/bash

docker run --rm -it -p 5901:5901 -p 6901:6901 --security-opt seccomp=./src/seccomp/chrome.json --shm-size=2g ubuntu-vnc