#!/bin/bash
BASEDIR=$(dirname $(readlink -f "$0"))
cd $BASEDIR
scripts/setup-workspace.sh | tee ~/setup-workspace.log
