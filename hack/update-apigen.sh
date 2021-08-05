#!/bin/bash

set -e

bin/gojsonschema -p schema pkg/schema/schema.json > pkg/schema/schema.go
