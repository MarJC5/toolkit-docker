#!/bin/bash

set -e

# Get ARGS
command=$1
arg=$2

if [[ $command == "push" ]]; then
    # Add all files to git from ./srcs/nodejs/themes/toolkit
    git -C "./srcs/nodejs/themes/toolkit" add .

    # Commit with message
    if [[ -z $arg ]]; then
        read -p "Commit message: " arg
    fi
    git -C "./srcs/nodejs/themes/toolkit" commit -m "${arg}"

    # Push to remote
    git -C "./srcs/nodejs/themes/toolkit" push
elif [[ $command == "pull" ]]; then
    # Pull from remote
    git -C "./srcs/nodejs/themes/toolkit" pull
elif [[ $command == "status" ]]; then
    # Show git status from "./srcs/nodejs/themes/toolkit"
    git -C "./srcs/nodejs/themes/toolkit" status
elif [[ $command == "clone" ]]; then
    # Clone from remote
    git clone "${arg}" "./srcs/nodejs/themes/toolkit"
else
    echo "Invalid command"
fi