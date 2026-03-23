#!/bin/sh

set -eu

cd priv

rm -f fixi.min.js fixi.min.js.gz fixi.min.js.br
npx terser fixi.js --format quote_style=1 -o fixi.min.js -c -m
gzip -k -9 fixi.min.js
brotli -k -Z fixi.min.js
