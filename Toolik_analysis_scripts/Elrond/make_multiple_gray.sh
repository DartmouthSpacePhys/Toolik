#!/bin/bash

files=/daq/april/end/*.fft

for f in $files
do
    gray -d $f.ngdef $f
    mv gray.ps  $f.ps
    scp $f.ps aurora@saramago.dartmouth.edu:/data/Toolik/Toolik_grayscales
done
