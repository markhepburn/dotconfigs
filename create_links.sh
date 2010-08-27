#!/bin/bash

# # This is in .bashrc; uncomment if necessary though:
# function canonicalise {
#     local dirpart=`dirname $1`
#     cd $dirpart && pwd -P
# }

CURRENTDIR=`canonicalise $0`

for dotfile in `ls -aF | grep -v '/$' | grep '^\.'`; do
    ln -si "${CURRENTDIR}/$dotfile" ~/$dotfile
done