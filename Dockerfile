FROM    ubuntu:latest

RUN \
  apt-get update && \
  apt-get install -y curl && \
  curl -sL https://deb.nodesource.com/setup | sudo bash - && apt-get install -y nodejs \
  build-essential && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list && \
  apt-get update && apt-get install -y mongodb-org

COPY app /src

EXPOSE  5000
CMD ["cd", "/src/app"]
CMD ["npm", "install"]
CMD ["npm", "start"]
