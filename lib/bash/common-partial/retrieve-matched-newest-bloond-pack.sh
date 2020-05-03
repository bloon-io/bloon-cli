#!/bin/bash
MATCHED_BLOON_VERSION=$(cat $BLOON_CLI_HOME/MATCHED_BLOON_VERSION)

DOWNLOAD_PATH=$BLOON_CLI_HOME/tmp.download

cd $BLOON_CLI_HOME
mkdir -p $DOWNLOAD_PATH

TMP_BLOOND_FILE_NAME="bloon-daemon-$MATCHED_BLOON_VERSION.tgz"
cd $DOWNLOAD_PATH
if ! [ -f $DOWNLOAD_PATH/$TMP_BLOOND_FILE_NAME ]; then
    wget https://host.bloon.io/share/a_q0s919RLaTtlQL43JnAg/$TMP_BLOOND_FILE_NAME
fi

rm -f matched-newest-bloond-pack.tgz
ln -s $TMP_BLOOND_FILE_NAME matched-newest-bloond-pack.tgz
