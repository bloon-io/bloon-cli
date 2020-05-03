#!/bin/bash
APP_PATH=$(dirname "$(realpath "$0")")
BLOON_CLI_HOME="$APP_PATH/../.."
# --------------------------------------------------

# for debug only
# export LD_LIBRARY_PATH=/home/patwang/_gitClone/project_LEXIPON/Bloon_Client/build-hero-Desktop_Qt_5_9_1_GCC_64bit-Debug/src/main:$LD_LIBRARY_PATH
# /home/patwang/_gitClone/project_LEXIPON/Bloon_Client/build-hero-Desktop_Qt_5_9_1_GCC_64bit-Debug/src/main/Bloon 2> /dev/null &

# TODO use random port
$BLOON_CLI_HOME/bloond 52811 &

sleep 1
