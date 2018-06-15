!#/bin/bash
#add a header on the file
#/usr/ggse/bin/addhead.py $1
#Run the FFT program
#/usr/src/daily_processing_code_elrond/test.pro -a 12 -m16 -t 2.0 -N 8192 $1
/usr/src/daily_processing_code_elrond/test.pro -a 12 -m20 -t 2.0 -N 8192 $1
#/usr/src/daily_processing_code_elrond/daily_processing_code_elrond_new_agc -a 30 -m1 -t 1.0 -N 8192 $1
#/usr/src/daily_processing_code_elrond/daily_processing_code_elrond_new_agc -a 1 -m1 -t 79205 -N 8192 $1
#Make the grayscales
gray -d ${1%%.*}.ch1.fft.ngdef ${1%%.*}.ch1.fft
mv gray.ps ${1%%.*}.ch1.ps
gray -d ${1%%.*}.ch2.fft.ngdef ${1%%.*}.ch2.fft
mv gray.ps ${1%%.*}.ch2.ps
gray -d ${1%%.*}.ch3.fft.ngdef ${1%%.*}.ch3.fft
mv gray.ps ${1%%.*}.ch3.ps
gray -d ${1%%.*}.ch4.fft.ngdef ${1%%.*}.ch4.fft
mv gray.ps ${1%%.*}.ch4.ps

#mv $1 /data/

#Copy the files back to gandalf
scp ${1%%.*}.ch1.ps aurora@saramago.dartmouth.edu:/data/Toolik/Toolik_grayscales/
scp ${1%%.*}.ch2.ps aurora@saramago.dartmouth.edu:/data/Toolik/Toolik_grayscales/
scp ${1%%.*}.ch3.ps aurora@saramago.dartmouth.edu:/data/Toolik/Toolik_grayscales/
scp ${1%%.*}.ch4.ps aurora@saramago.dartmouth.edu:/data/Toolik/Toolik_grayscales/

#mv $1 /data/
