#!/usr/bin/env bash
echo "Restoring database"
psql -U postgres grafana < /home/grafanaDump.sql
echo "Database restored successfully"
