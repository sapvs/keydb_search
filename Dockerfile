ARG KEYDB_IMAGE_VERSION
FROM eqalpha/keydb:${KEYDB_IMAGE_VERSION} AS builder 
RUN apt update
RUN apt install -y git make 

ARG BRANCH
WORKDIR /keydb
RUN git clone -b ${BRANCH} --recursive https://github.com/RediSearch/RediSearch.git
RUN cd RediSearch && make setup  && make build 

FROM eqalpha/keydb:${KEYDB_IMAGE_VERSION}
COPY --from=builder /keydb/RediSearch/bin/linux-x64-release/search/redisearch.so /etc/libs/redisearch.so
CMD [ "--loadmodule", "/etc/libs/redisearch.so" ]
