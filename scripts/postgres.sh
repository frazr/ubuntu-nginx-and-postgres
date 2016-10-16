#!/bin/bash
set -eo pipefail
shopt -s nullglob

#su postgres --command "/usr/lib/postgresql/9.3/bin/initdb -D /data/postgres/main && CREATE USER docker WITH SUPERUSER PASSWORD 'docker';"
#su postgres --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';"
#su postgres --command 'createdb -O docker docker'