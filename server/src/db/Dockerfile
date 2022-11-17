FROM postgres:12
COPY init.sql /docker-entrypoint-initdb.d/
COPY restoreGrafana.sh /docker-entrypoint-initdb.d/restore.sh
COPY grafanaDump.sql /home/grafanaDump.sql
EXPOSE 5432
