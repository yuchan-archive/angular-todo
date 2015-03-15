FROM    ubuntu:latest

RUN     curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN     apt-get install -y nodejs

RUN     apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN     echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
RUN     apt-get update
RUN     apt-get install -y mongodb-org
RUN     service mongod start

ADD . /src
RUN cd /src; npm install
EXPOSE  5000
CMD ["cd", "/src"]
CMD ["npm", "start"]
