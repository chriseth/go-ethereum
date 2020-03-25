#!/bin/bash
set -e
geth init genesis.json
geth --config config.toml --syncmode "full"
