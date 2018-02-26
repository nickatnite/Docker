#!/bin/bash
docker rmi $(docker images -q -a)
docker rm $(docker ps -q -a)
