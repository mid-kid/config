#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/celeste}"
cd "$prefix"
exec ./Celeste "$@"
