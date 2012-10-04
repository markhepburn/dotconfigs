#!/bin/bash

# # This is in .bashrc; uncomment if necessary though:
# function canonicalise {
#     local dirpart=`dirname $1`
#     cd $dirpart && pwd -P
# }

CURRENTDIR=`canonicalise $0`

# For simple dot-files we just symbolically link them in $HOME:
for dotfile in `ls -aF | grep -v '/$' | grep '^\.'`; do
    ln -si "${CURRENTDIR}/$dotfile" ~/$dotfile
done

# Directory-structured things are a bit more complicated; the main
# culprit is things that live in ~/.config.  I don't want to keep
# everything in .config versioned so I can't just link ~/.config in
# here, so we do a bit of a dance of creating any non-existing
# directory components, then linking files in here to the actual
# directories in $HOME.
for DIR in `find . -type d | grep -v .git | grep -v ^\.$`; do
    mkdir -p ~/${DIR}
done
for DIR in `find . -maxdepth 1 -type d | grep -v .git | grep -v ^\.$`; do
    for CONF in `find ${DIR} -type f`; do
        BASEDIR=`dirname ${CONF}`
        ln -si ${CURRENTDIR}/${CONF} ~/${BASEDIR}
    done
done
