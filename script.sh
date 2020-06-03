#!/bin/bash
SQL_AJUSTE=`cat scripts.sql`
#Create database
    echo "RODANDO SQL..."
    docker exec -t postgres sh -c "psql -U postgres --dbname '$1' -c '$SQL_AJUSTE';"
