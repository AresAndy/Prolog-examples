#!/bin/sh
#
# Make script (make.sh)
#
# This scripts batch-calls SWI Prolog script interpreter, and
# launches the compile script, like Make would do.
#
# AresAndy
# License = BSD

swipl -F none -f make.prolog
