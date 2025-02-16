#!/bin/sh
./inner.sh $*
./inner.sh $@
./inner.sh "$*"
./inner.sh "$@"