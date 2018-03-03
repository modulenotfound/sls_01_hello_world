FROM ubuntu:latest

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

#install aws cli
RUN apt-get -y update && apt-get install -y curl git python python-pip
RUN pip install --upgrade pip
RUN pip install awscli

ENV AWS_ACCESS_KEY_ID <your_aws_access_key_id>
ENV AWS_SECRET_ACCESS_KEY <your_aws_secret_access_key>
ENV AWS_DEFAULT_REGION us-east-2

#install nvm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.10.3
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

#install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

#install serverless
RUN npm install -g serverless

WORKDIR /home/dev
CMD /bin/bash
