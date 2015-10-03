FROM ubuntu:14.04
MAINTAINER nirbhay@mariadb.com

# Install MariaDB Galera cluster
RUN apt-get -y install software-properties-common                                                      && \
      apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db             && \
      add-apt-repository 'deb http://mirrors.syringanetworks.net/mariadb/repo/10.0/ubuntu trusty main' && \
      apt-get update                                                                                   && \
      apt-get -y install mariadb-galera-server

# Expose all the necessary ports:
#   3306 : MySQL client connections
#   4444 : Snapshot state transfer (SST)
#   4567 : Galera cluster replication traffic
#   4568 : Incremental state transfer (IST)
EXPOSE 3306 4444 4567 4568

# Copy the local galera.cnf (mandatory settings)
COPY galera.cnf /etc/mysql/conf.d/

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
