#!/bin/tcsh

get_file_list.pl -keys "path,filename,year" -cond "trgsetupname=AuAu200_production,filetype=daq_reco_MuDst,storage=local,site=BNL,sanity=1,filename~st_physics" -limit all


