#!/bin/bash
name=derpibooru-pg-dump

docker stop $(docker ps -a | grep $name | awk '{print $1}')