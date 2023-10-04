#!/bin/bash
BASEDIR=$(dirname $(readlink -f "$0"))
cd $BASEDIR
scripts/setup-workspace.sh 2>&1 | tee ~/setup-workspace.log
