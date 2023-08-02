#!/bin/sh
if [ -f "$1" ]; then
  cp "$1" "$2"
fi