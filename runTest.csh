#!/bin/tcsh

#root4star -b -l -q StRoot/macros/runMuDstAna.C'("muDst.test.list", 2, "testEnergy")'

#root4star -b -l -q StRoot/macros/runMuDstAna.C'("test39.list", 1, "testEnergy_39")'

root4star -b -l -q StRoot/macros/runMuDstAna.C'("root://xrdstar.rcf.bnl.gov:1095//home/starlib/home/starreco/reco/AuAu39_production/ReversedFullField/P10ik/2010/098/11098073/st_physics_11098073_raw_5040001.MuDst.root", 1, "testEnergy_39")'
