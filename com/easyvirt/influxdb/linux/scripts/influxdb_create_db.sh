#!/bin/bash -e

CMD="CREATE DATABASE "$DB_USER

influx -execute "${CMD}"
