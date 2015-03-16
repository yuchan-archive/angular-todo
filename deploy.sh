#!/bin/sh

# On Mac OS X, you don't need to add `sudo`.

start(){
  docker build -t yuchan/angular-todo .
  docker pull tutum/mongodb

  docker run -d -p 27017:27017 -p 28017:28017 -e AUTH=no --name mongodb tutum/mongodb
  docker run -d -p 5000:5000 --link mongodb:db --name web -t yuchan/angular-todo
}

stop() {
  docker stop web mongodb
  docker rm web mongodb
}

addr() {
  echo $(boot2docker ip 2>/dev/null)
}

option="${1}"
case ${option} in
  "start")
      start
      ;;
  "stop")
      stop
      ;;
  "restart")
      stop
      start
      ;;
  "addr")
      addr
      ;;
  *)
      echo "Usage: ./deploy.sh {start, stop, restart, addr}"
      ;;
esac
