#!/bin/bash
darnit=/daq/full/*.data
for f in $darnit
do
    process_elrond.sh  $f
    #process_elrond_mod_start.sh      

done
