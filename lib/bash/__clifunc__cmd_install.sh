#!/bin/bash
APP_PATH=$(dirname "$(realpath "$0")")

WORK_PATH=$BLOON_CLI_HOME/work
DOWNLOAD_PATH=$BLOON_CLI_HOME/tmp.download
# --------------------------------------------------

cd $BLOON_CLI_HOME
mkdir -p $WORK_PATH

$APP_PATH/common-partial/retrieve-matched-newest-bloond-pack.sh

cd $WORK_PATH
mkdir tmp.untar
cd tmp.untar
tar zxfv $DOWNLOAD_PATH/matched-newest-bloond-pack.tgz
mv ./* BLOON # use this way to accept any dir. name after untar

cd $WORK_PATH
# TODO give a WARN confirm (Y/N) that this install will clean old install first
#   (or we can forbid the install process and asking user to exec. "bloon upgrade")
rm -rf $WORK_PATH/BLOON
mv tmp.untar/BLOON .
rm -rf tmp.untar

# --------------------------------------------------




# TODO to be continue...
