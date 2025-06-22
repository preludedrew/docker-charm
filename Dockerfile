FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get install -y npm

COPY app/ app/
RUN chmod +x /app/start.sh

RUN cd /app && npm install && cd node_modules/node-lmdb && node-gyp configure && node-gyp build

RUN ln -sf /data/lmdb-pages.sqsh /app/lmdb-pages.sqsh
RUN ln -sf /data/lmdb-images /app/lmdb-images

CMD ["/app/start.sh"]
