#!/usr/bin/env bash

# Debug mode
# set -x
set -e

GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}NodeJS setup${NC}"s
npm install

# Check project type webpack or gulp
if [ "$TOOLKIT_VERSION" = "webpack" ]
then
    echo -e "${GREEN}Webpack project${NC}"
    # Start the server regarding the environment
    if [ "$NODE_ENV" = "production" ]
    then
        echo -e "${GREEN}Production mode${NC}"
        npm run production
    else
        echo -e "${GREEN}Development mode${NC}"
        npm run watch
    fi
elif [ "$TOOLKIT_VERSION" = "plugin" ]
then
    echo -e "${GREEN}Plugin project${NC}"
    if [ "$NODE_ENV" = "production" ]
    then
        echo -e "${GREEN}Production mode${NC}"
        npm run production
    else
        echo -e "${GREEN}Development mode${NC}"
        npm run watch
    fi
else
    echo -e "${GREEN}Gulp project${NC}"
    # Install gulp if not installed
    if [ ! -f /usr/local/bin/gulp ]
    then
        echo -e "${GREEN}Install gulp${NC}"
        npm install -g gulp-cli
        npm install -g gulp
    fi

    expect /usr/src/app/gulp_install.expect

    npm run watch
fi
