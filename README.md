# muDstReaderExtractRefMult
extract refMult2 from MuDsts using the Star scheduler 

Get all MuDst files for a certain BES energy and extract refMult/refMult2 for every of those.

## Run 
Change `set energy=XXX` in `submit.csh` to adopt for other energies.

## Output 
Text files following the `<day>/<run>/<basefilename>.refMult.txt`  structure 
containing for every event:

`run       event     gRefMult   refMult  refMult2`


