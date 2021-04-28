#!/bin/sh
set -xev

CUR_DIR=$(pwd)

ln -s ${CUR_DIR}/tmuxp ~/.tmuxp
ln -s ${CUR_DIR}/zshrc.local ~/.zshrc.local

