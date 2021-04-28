#!/bin/sh
set -xv

CUR_DIR=$(pwd)

ln -s ${CUR_DIR}/tmuxp ~/.tmuxp
ln -s ${CUR_DIR}/zshrc ~/.zshrc
ln -s ${CUR_DIR}/zshrc.local ~/.zshrc.local

