FROM cikl/base:0.0.2
MAINTAINER Mike Ryan <falter@gmail.com>

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -y redis-server=2:2.8.4-2 && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Define mountable directories.
VOLUME ["/data"]

ENV ENTRYPOINT_DROP_PRIVS 1
ENV ENTRYPOINT_USER redis

ADD redis-command.sh /etc/docker-entrypoint/commands.d/redis
ADD redis-pre.sh /etc/docker-entrypoint/pre.d/redis-pre.sh
RUN chmod a+x /etc/docker-entrypoint/commands.d/redis

ADD redis.conf /etc/redis/redis-cikl.conf

# Define working directory.
WORKDIR /data

# Define default command.
CMD [ "redis" ]

EXPOSE 6379
