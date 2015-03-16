FROM    ubuntu:latest

RUN \
  apt-get update && \
  apt-get install -y curl && \
  curl -sL https://deb.nodesource.com/setup | sudo bash - && apt-get install -y nodejs

COPY app /src
EXPOSE  5000

WORKDIR /src

COPY app/package.json /tmp/package.json
RUN  cd /tmp && npm install && cp -a node_modules /src/node_modules

CMD ["npm", "start"]
