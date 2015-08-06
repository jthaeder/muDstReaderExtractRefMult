#!/bin/csh
#  
#  Script to split up a fileList of MuDst.root files
#  and process them in individual root4star sessions
#
# ###############################################
# ${FILELIST} &basePath; &prodId; &rootMacro; &energy; &starVersion; ${JOBID}

set fileList=$1
set basePath=$2
set prodId=$3
set rootMacro=$4
set energy=$5
set starVersion=$6
set jobId=$7

echo FILELIST $fileList
echo $starVersion

foreach line ( `cat $fileList` )
    set fileBaseName=`basename $line`
    echo $fileBaseName | grep ".root" > /dev/null
    
    if ( $status == 1 ) then
	continue
    endif

    set day=`perl $STAR/StRoot/macros/embedding/getYearDayFromFile.pl -d ${fileBaseName}`
    set run=`perl $STAR/StRoot/macros/embedding/getYearDayFromFile.pl -r ${fileBaseName}`

    set oldSTAR_VERSION=$STAR_VERSION
    starver $starVersion

    set outDir=${basePath}/production/refMult_${energy}/${day}/${run}
    set logDir=${basePath}/jobs/log/${prodId}/${day}/${run}

    mkdir -p $outDir $logDir
    
    set outName=`echo $fileBaseName | awk -F ".MuDst.root" '{ print $1 }'`
    
    root4star -q -b -l StRoot/macros/${rootMacro}'("'${line}'", 1, "'${outName}'")'

    starver $oldSTAR_VERSION
    mv ${outName} refMult.txt $outDir
end
