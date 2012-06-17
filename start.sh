#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "ruby $DIR/listen.rb" | at now + 1 minute
