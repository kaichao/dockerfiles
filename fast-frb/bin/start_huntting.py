#!/usr/bin/env python

# import numpy as np
#import socket
import os,sys
# import glob
import time

#Input Dir: ./input_name/FRB190520/20200522/
#Input File name: FRB190520_tracking-M**_****.fil, 
#e.g.: FRB190520_tracking-M01_0077.fil

#Output Dir: ./output_name/FRB190520/20200522/
#Output File name: *.cand,  e.g.: 2020-05-22-08:15:57_01.cand


fil_file	= sys.argv[1]
project		= fil_file.split('input/')[-1].split('/')[0]
date		= fil_file.split('input/')[-1].split('/')[1]
beam		= fil_file.split('input/')[-1].split('/')[-1].split('M')[-1].split('_')[0]
opt		= '-nsamps_gulp 10000000'
out_dir 	= 'output/%s/%s/'%(project,date)
if not os.path.exists(out_dir):
	os.makedirs(out_dir)	

os.system("heimdall -dm 10 5000 -f %s -beam %s  %s -output_dir %s"%(fil_file,beam, opt,out_dir))

exit()

#sys.stdout.flush()

#pathlist = glob.glob(file_dir + project + date+"/*.fil")
#pathlist = sorted(pathlist,key=lambda s:s.split("_")[-1].split(".")[-2])
#for ii in np.arange(len(pathlist)):	
 #   if ii % 2 == 0:
#	fil_file = pathlist[ii]
#	print fil_file.split("/")[-1]
#	sys.stdout.flush()
#	os.system("heimdall -dm 10 5000 -f %s -gpu_id 0 -output_dir %s"%(fil_file,out_dir))
#print "Done!\n"
#sys.stdout.flush()
