FROM golang
RUN apt-get update && apt-get install -y build-essential g++ git wget curl ruby bison flex
RUN mkdir -p /go/src/github.com/mitchellh
ENV GOPATH=/go
RUN go get github.com/docker/engine-api && \
    go get github.com/docker/distribution/reference && \
    go get github.com/docker/go-connections/nat && \
    go get github.com/docker/go-units && \
    go get golang.org/x/net/context && \
    go get github.com/Sirupsen/logrus && \
    go get github.com/opencontainers/runc/libcontainer/user 
RUN cd /go/src/github.com/mitchellh && \
    git clone https://github.com/erikh/go-mruby && \
    cd go-mruby && \
    git fetch && \
    git checkout -b class origin/class
RUN cd /go/src/github.com/mitchellh/go-mruby && \
    make && \
    cp libmruby.a /root/
RUN cd /root && \
    wget https://gist.githubusercontent.com/erikh/b45e9f45e2cd2f2937dfda0d2bd35cfb/raw/28633f70b0c4152eb6361ae8ae8c3ee0d2dfcc44/main.go && \
    go build main.go
