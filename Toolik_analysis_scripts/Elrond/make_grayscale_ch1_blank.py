#!/usr/bin/python
import sys, os, subprocess, glob
import datetime

############USER-DEFINFED PARAMETERS###############

data_dir = '/daq/'
processed_dir = '/daq/processed/'

N = 8192 #NUMBER OF POINTS IN THE FFT
a = 1 #NUMBER OF SPECTRA TO AVERAGE
m = 1 #NUMBER OF AVERAGED SPECTRA TO MAX
delta_t = 2.0 #TIMESTAMP DELTA_T

##################

#For all files that match the pattern
for file in glob.glob(data_dir + '2013*TLK*.data'):
	print file
    #Make sure you don't process the data file that is current being written to by the ADC
	name_split = file.split('/')
	more_split = name_split[-1].split('-')
	print more_split[0][0:4]
	file_date = datetime.date(year=int(more_split[0][0:4]), month=int(more_split[0][4:6]), day=int(more_split[0][6:8]))
	current_date = datetime.date.today()

	if (file_date!= current_date):
#        print "date parsed!"
		print "data parsed!"
	else:
		#Fix the swapped data
		print "unswapping!"
		subprocess.call(['/usr/src/fix_random_swap/fix_random_swap_ch1_blank -N {0} -a{1} {2}'.format(N,a,file)],shell=True, cwd=data_dir)

		#Parse the filename
		split_file = file.split('.')
		no_split_file = split_file[0]+'_no_swap.data'
		ps_files = split_file[0]+'_no_swap*.ps'
		swap_file = split_file[0]+'_swapped.data'

		#process the data file with swapping fixed
		#subprocess.call(['/usr/src/daily_processing_code_elrond/test.pro -a 12 -m20 -t 2.0 -N 8192 {0}'.format(no_split_file)],shell=True,cwd=data_dir)
	   	#subprocess.call(['/usr/src/daily_processing_code_elrond/test.pro -a 1 -m1 -t 2.0 -N 8192 {0}'.format(no_split_file)],shell=True,cwd=data_dir)
		subprocess.call(['/usr/src/daily_processing_code_elrond/test.pro -a {0} -m{1} -t{2} -N{3} {4}'.format(a, m, delta_t, N, no_split_file)],shell=True,cwd=data_dir)

		#Make the graydata files
		print data_dir + split_file[0] + '*.fft'
		for graydata_file in glob.glob(split_file[0] + '*.fft'):
			print graydata_file
			subprocess.call(['gray -d {0} {1}'.format(graydata_file + '.ngdef',graydata_file)],shell=True, cwd=data_dir)
			subprocess.call(['mv {0} {1}'.format(data_dir + 'gray.ps',graydata_file+'.ps')],shell=True, cwd=data_dir)
			subprocess.call(['ps2pdf {0}'.format(graydata_file+'.ps')],shell=True,cwd=data_dir)
		
		#Send ps files and pdf files to aristotle
		for ps in glob.glob(split_file[0]+'*.ps'):
			subprocess.call(['scp {0} aurora@saramago.dartmouth.edu:/data/Toolik/Toolik_grayscales'.format(ps)],shell=True, cwd=data_dir)
		for pdf in glob.glob(split_file[0]+'*.pdf'):
			subprocess.call(['scp {0} aurora@saramago.dartmouth.edu:/data/Toolik/Toolik_grayscales'.format(pdf)],shell=True, cwd=data_dir)

		#Move data file to the processed directory. Removed swap-corrected files
		subprocess.call(['mv {0} {1}'.format(file, processed_dir)],shell=True,cwd=data_dir)
		subprocess.call(['rm {0}'.format(no_split_file)],shell=True, cwd=data_dir)
		subprocess.call(['rm {0}'.format(swap_file)],shell=True, cwd=data_dir)
