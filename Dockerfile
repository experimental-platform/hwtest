FROM ubuntu:14.04
MAINTAINER Kamil Domanski (kamil.domanski@protonet.info)

ENV GOPATH=/gopath
RUN mkdir -p $GOPATH
RUN echo "deb http://ppa.launchpad.net/evarlast/golang1.4/ubuntu trusty main" >> /etc/apt/sources.list.d/golang1.4.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B0B8B106A0CA2F79FBB616DBA65E2E5D742A38EE
RUN apt-get update && apt-get install -y \
      v4l-utils \
      alsa-utils \
      golang-go \
      git \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN go get -u github.com/Sirupsen/logrus github.com/jacobsa/go-serial/serial
COPY serial.go /serial.go
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["v4l2-ctl --list-devices && ( aplay -l | grep '^card [0-9]*:' || ( echo No sound card found.; exit 1) ) && go run /serial.go"]
