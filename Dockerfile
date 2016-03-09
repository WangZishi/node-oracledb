FROM node:5.7.1
MAINTAINER Wang Zishi "ynh.2@outlook.com"

WORKDIR /tmp
COPY pkg/* ./

RUN apt-get update && \
    apt-get install -y alien && \
    apt-get autoremove && \
    apt-get clean
RUN alien -i oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm && \
    alien -i oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm

WORKDIR /usr/src
RUN npm install oracledb

CMD ["node"]