#!/bin/tcsh


set xmlFile=submit.xml

set rootMacro=runMuDstAna.C

set baseFolder=`pwd`
set productionId=`date +%F_%H-%M`

set energy=39

if ( $energy == 27 ) then 
    set trgSetup=AuAu27_production_2011
    set starVersion=SL10h
else if ( $energy == 39 ) then 
    set trgSetup=AuAu39_production
    set starVersion=SL10h
else
    exit
endif


echo "Energy:        $energy"
echo "STARversion:   $starVersion"
echo "Trigger Setup: $trgSetup"

# ###############################################
# -- DON'T CHANGE BELOW THAT LINE
# ###############################################

# -- job submission directory
mkdir -p ${baseFolder}/jobs

# -- result directory
mkdir -p ${baseFolder}/production/${productionId}

pushd ${baseFolder}/jobs > /dev/null

# -- prepare folder
mkdir -p report log list csh

# -----------------------------------------------

# -- Compile
set oldSTAR_VERSION=$STAR_VERSION
starver $starVersion
rm-rf .sl64_gcc447
cons
starver $oldSTAR_VERSION
exit
# -----------------------------------------------

# -- check for prerequisits and create links
set folders=".sl64_gcc447 StRoot starSubmit"

echo -n "Checking prerequisits folders ...  "
foreach folder ( $folders ) 
    if ( ! -d ${baseFolder}/${folder} ) then
	echo "${folder} does not exist in ${baseFolder}"
	exit
    else
	ln -sf  ${baseFolder}/${folder}
    endif
end
echo "ok"

# -----------------------------------------------

echo -n "Checking run macro ...             "
if  ( ! -e ${baseFolder}/StRoot/macros/${rootMacro} ) then
    echo "${rootMacro} does not exist in ${baseFolder}/StRoot/macros"
    exit
endif
echo "ok"

# -----------------------------------------------

echo -n "Checking xml file  ...             "
if ( ! -e ${baseFolder}/starSubmit/${xmlFile} ) then
    echo "XML ${xmlFile} does not exist"
    exit
else
    ln -sf ${baseFolder}/starSubmit/${xmlFile} 
endif
echo "ok"

# -----------------------------------------------

if ( -e LocalLibraries.zip ) then
    rm LocalLibraries.zip
endif 

if ( -d LocalLibraries.package ) then
    rm -rf LocalLibraries.package
endif 

# ###############################################
# -- submit 
# ###############################################

    star-submit-template -template ${xmlFile} -entities basePath=${baseFolder},prodId=${productionId},rootMacro=${rootMacro},energy=${energy},trgSetup=${trgSetup},starVersion=${starVersion}

popd > /dev/null



