FROM node:6.2.0
MAINTAINER Wang Zishi <ynh.2@outlook.com>

# 设置系统时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

# 复制 Oracle 客户端
WORKDIR /tmp
COPY pkg/* ./

# 安装 Oracle 客户端及其依赖项
RUN apt-get update && \
    apt-get install -y alien && \
    apt-get install -y libaio1 && \
    apt-get autoremove && \
    apt-get clean
RUN alien -i oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm && \
    alien -i oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm

# 全局安装 oracledb 及 excel，并修改 NODE_PATH
WORKDIR /
RUN npm install oracledb excel -g
ENV NODE_PATH=/usr/local/lib/node_modules

CMD ["node"]