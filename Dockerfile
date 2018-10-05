FROM gliderlabs/alpine:3.6

ARG REFRESHED_AT=2018-10-05

RUN apk-install mysql-client

ENTRYPOINT ["mysql"]