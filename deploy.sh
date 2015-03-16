#!/bin/sh

# On Mac OS X, you don't need to add `sudo`.

start(){
  case $1 in
    "web")
    docker build -t yuchan/angular-todo .
    docker run -d -p 5000:5000 --link mongodb:db --name web -t yuchan/angular-todo
    ;;
    "db")
    docker pull tutum/mongodb
    docker run -d -p 27017:27017 -p 28017:28017 -e AUTH=no --name mongodb tutum/mongodb
    ;;
    *)
    docker build -t yuchan/angular-todo .
    docker pull tutum/mongodb
    docker run -d -p 27017:27017 -p 28017:28017 -e AUTH=no --name mongodb tutum/mongodb
    docker run -d -p 5000:5000 --link mongodb:db --name web -t yuchan/angular-todo
    ;;
  esac
}

stop() {
  docker stop $1
  docker rm $1
}

addr() {
  echo $(boot2docker ip 2>/dev/null)
}

option="${1}"
case ${option} in
  "init")
      start
      ;;
  "start")
      start web
      ;;
  "stop")
      stop web
      ;;
  "restart")
      stop web
      start web
      ;;
  "addr")
      addr
      ;;
  *)
      echo "Usage: ./deploy.sh {start, stop, restart, addr}"
      ;;
esac
