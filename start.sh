#!/bin/bash
name=derpibooru-pg-dump

docker start $(docker ps -a | grep $name | awk '{print $1}')