#!/usr/bin/env bash
TAG=1.0

docker build --target production -t pingaling/api:$TAG .
