#!/bin/sh

# On Mac OS X, you don't need to add `sudo`.

docker build -t yuchan/angular-todo .
docker pull tutum/mongodb

docker run -d -p 27017:27017 -p 28017:28017 -e AUTH=no --name mongodb tutum/mongodb
docker run -d -p 5000:5000 --link mongodb:db --name web -t yuchan/angular-todo
