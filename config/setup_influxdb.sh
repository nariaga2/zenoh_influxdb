#!/bin/bash

# Setup the Influx CLI: https://docs.influxdata.com/influxdb/v2/get-started/setup/?t=Set+up+with+the+API
export INFLUXDB_USERNAME=ecmpg
export INFLUXDB_PASSWORD=ecmpg1234
export INFLUXDB_CONFIG_NAME=ecmpg
export INFLUXDB_ORG=ecmpg
export INFLUXDB_API_TOKEN='_djIO2Eq4Nukcv6iTD9zUzlirSv38f1IWRt85TFifWHtrYOJe8DI4tDr5m9dOiSwL3wPfyYMPoyUN3hDuMdDvw=='
export INFLUXDB_BUCKET_NAME=zenoh_example

influx setup \
    --username $INFLUXDB_USERNAME \
    --password $INFLUXDB_PASSWORD \
    --token $INFLUXDB_API_TOKEN \
    --org $INFLUXDB_ORG \
    --bucket $INFLUXDB_BUCKET_NAME \
    --force