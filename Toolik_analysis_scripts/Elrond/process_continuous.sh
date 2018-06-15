#!/bin/bash
#darnit=/data/continuous/*.data
#for f in $darnit
def=${1}.ngdef
graydata=${1}.fft
ps=${1}.ps
pdf=${1}.pdf
#freq is the sampling frequency in Hertz
freq=$2

#split the filename to get the correct filename
filename=${1#*/}
short_name=${filename%-*}
shorter_name=${short_name#*/}
time_start=${shorter_name#*-}
echo $filename
echo $shorter_name
echo $time_start
#do 
	/usr/src/fft_continuous/fft_continuous -N 8192 -t $time_start -s 1 -a 12 -m 1 -l 0 -h 5000 -f $2 $1
	gray -d $def $graydata
	mv gray.ps $ps
#	mv $1 /data/continuous/2011_processed/
#	scp $ps aurora@saramago.dartmouth.edu:/data/Toolik/
    ps2pdf $ps
#    scp $pdf aurora@saramago.dartmouth.edu:/data/Toolik/Toolik_grayscales/
#done
	
