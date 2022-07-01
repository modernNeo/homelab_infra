#!/bin/bash

set -e -o xtrace
# https://stackoverflow.com/a/5750463/7734535

tunnel --no-autoupdate run --token ${TUNNEL_TOKEN}