#!/bin/bash
files=/daq/april/end/*.data
for f in $files
do
    process_elrond_mod_start.sh $f
done
