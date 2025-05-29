#!/bin/bash

# Set persistence mode
sudo nvidia-smi -pm 1
# Set power limit in Watts
sudo nvidia-smi -pl 100
# Limit clock speed min,max
sudo nvidia-smi -lgc 0,1785 --mode=1
# Set clock offset
sudo nvidia-tuner -c 150
