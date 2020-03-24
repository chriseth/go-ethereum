#!/bin/bash
set -e
echo "Test"
which geth
geth init genesis.json
geth --config config.toml
