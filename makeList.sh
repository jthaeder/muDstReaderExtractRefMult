#!/bin/tcsh

get_file_list.pl -keys "path,filename" -cond "trgsetupname=AuAu39_production,filetype=daq_reco_MuDst,storage=local,site=BNL,sanity=1,filename~st_physics" -limit 10 
