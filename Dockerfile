FROM    ubuntu:latest

RUN \
  apt-get update && \
  apt-get install -y curl && \
  curl -sL https://deb.nodesource.com/setup | sudo bash - && apt-get install -y nodejs

COPY . /src
EXPOSE  5000

WORKDIR /src

RUN  npm install

CMD ["npm", "start"]
