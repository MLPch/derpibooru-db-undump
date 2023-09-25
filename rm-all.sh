#!/bin/bash
name=derpibooru-pg-dump

docker stop $(docker ps -a | grep $name | awk '{print $1}')

docker rm $(docker ps -a | grep $name | awk '{print $1}')

docker rmi $(docker images -a | grep $name | awk '{print $3}')

docker volume prune -f

docker network prune -f
