#!/bin/bash
PATH_DOWNLOAD=/home/arcosta/Downloads/

#Run backup
    echo "DIGITE O NOME DO BD "
    read DB_NAME
    docker exec -t postgres sh -c "pg_dump -U postgres -Fc $DB_NAME > /opt/bkp/$DB_NAME-backup.backup"

#Mover para Downloads
    mv "/desenv/volumes/postgres/bkp/$DB_NAME-backup.backup" $PATH_DOWNLOAD
