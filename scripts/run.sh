#!/bin/bash

DEFAULT_PS_DIR="/var/lib/postgresql/9.3/main"
export PS_DATA_DIR="/data/postgres/main"

function create_postgres_data {
    if [[ ! -d $PS_DATA_DIR ]]; then
        echo "=> An empty or uninitialized POSTGRES volume is detected in $PS_DATA_DIR"
        echo "=> Installing PostgreSQL ..."
		
		mkdir -p $PS_DATA_DIR

		service postgresql status
		cp -R $DEFAULT_PS_DIR/* $PS_DATA_DIR

		rm -r $DEFAULT_PS_DIR
        ln -s $PS_DATA_DIR $DEFAULT_PS_DIR

		chown -R postgres. $PS_DATA_DIR
		chmod 700 $PS_DATA_DIR

		/root/scripts/postgres.sh
        echo "=> Done!"  
    else
		su postgres --command="/usr/lib/postgresql/9.3/bin/initdb -D $PS_DATA_DIR"
        echo "=> Using an existing volume of PostgreSQL"
    fi
}

create_postgres_data
/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
