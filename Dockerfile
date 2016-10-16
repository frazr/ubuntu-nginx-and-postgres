FROM ubuntu:latest

# Install packages
ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    apt-get -y install \
    pwgen \
    supervisor \
    git \
    nginx \
    python-software-properties \
    software-properties-common \
    postgresql-9.3 \ 
    postgresql-client-9.3 \
    postgresql-contrib-9.3

# Add persistance volume 
VOLUME  ["/data"]

ADD scripts/* /root/scripts/
ADD rootfs /

RUN mkdir -p /var/run/postgresql/9.3-main.pg_stat_tmp && \
    chown postgres. /var/run/postgresql/9.3-main.pg_stat_tmp && \
    chmod 700 /var/run/postgresql/9.3-main.pg_stat_tmp

EXPOSE 80 5432
CMD ["/root/scripts/run.sh"]
