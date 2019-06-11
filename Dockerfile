FROM node:11.5.0-alpine

RUN apk --no-cache add --virtual native-deps \
  g++ gcc libgcc libstdc++ linux-headers make python

ADD package.json /tmp/package.json
RUN cd /tmp && npm install -qy
RUN mkdir -p /usr/src/app && cp -a /tmp/node_modules /usr/src/app/

WORKDIR /usr/src/app/
EXPOSE 8080

RUN apk del native-deps

COPY ./entrypoint.sh /
run chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]