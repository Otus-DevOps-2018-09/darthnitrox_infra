#!/bin/bash
if ! [ -d ~/reddit ]; then
git clone -b monolith https://github.com/express42/reddit.git && cd reddit && bundle install
else
rm -rf ~/reddit && git clone -b monolith https://github.com/express42/reddit.git && cd reddit && bundle install
fi