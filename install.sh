#!/bin/sh

# args = ( "$@" )
# this iterates over command line arguments
for arg; do
    echo Linking $arg
    stow --simulate --verbose=2 -R -S $arg -t ~
done
