#!/bin/bash

PATH_DOWNLOAD=/home/aureliorezendecosta/Downloads/
PATH_VOLUME=./postgres/bkp/calima.backup
BACKUP_FILE=""

echo "Digite o nome do BD ->> "
read DB_NAME
echo

if [ -n "$DB_NAME" -a $DB_NAME != "calima_testes" ]
then
    BACKUP_FILE=$(zenity --file-selection --class=CalimaServer --title="Selecione o Arquivo de Backup"  --file-filter='Backup do PostgreSQL (.backup) | *.backup' )
    echo "BACKUP ->> " $BACKUP_FILE
    
    if [ -n "$BACKUP_FILE" ]
    then
        #Move backup
        echo "$(date +'%m/%d/%Y - %H:%M:%S') -> MOVENDO ARQUIVO BD $BACKUP_FILE para $PATH_VOLUME"
        sudo mv $BACKUP_FILE $PATH_VOLUME
        #Clean connetcions
        echo "$(date +'%m/%d/%Y - %H:%M:%S') -> REMOVENDO CONEXOES ATIVAS COM $DB_NAME"
        docker exec -it postgres psql -U postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$DB_NAME';" 
        #Drop database
        echo "$(date +'%m/%d/%Y - %H:%M:%S') -> DROPANDO BD $DB_NAME"
        docker exec -t postgres sh -c "psql -U postgres -c 'drop database $DB_NAME;'"
        #Create database
        echo "$(date +'%m/%d/%Y - %H:%M:%S') -> CRIANDO BD $DB_NAME"
        docker exec -t postgres sh -c "psql -U postgres -c 'create database $DB_NAME;'"
        #Restore
        echo "$(date +'%m/%d/%Y - %H:%M:%S') -> RESTAURANDO $DB_NAME..."
        docker exec -t postgres sh -c 'pg_restore -U postgres -v --dbname '$DB_NAME' /opt/bkp/calima.backup'
        #Ajustando BD
        ./script.sh $DB_NAME
        echo "$(date +'%m/%d/%Y - %H:%M:%S') -> DELETANDO ARQUIVO DE BACKUP"
        sudo rm $PATH_VOLUME
        echo "$(date +'%m/%d/%Y - %H:%M:%S') -> Fim !!!"
    else
        echo "$(date +'%m/%d/%Y - %H:%M:%S') -> Backup não encontrado"
    fi
    
elif [ $DB_NAME = "calima_testes" ]
then
    echo "$(date +'%m/%d/%Y - %H:%M:%S') -> REMOVENDO CONEXOES ATIVAS COM $DB_NAME"
    docker exec -it postgres psql -U postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$DB_NAME';" 
    #Drop database
    echo "$(date +'%m/%d/%Y - %H:%M:%S') -> DROPANDO BD $DB_NAME"
    docker exec -t postgres sh -c "psql -U postgres -c 'drop database $DB_NAME;'"
    #Create database
    echo "$(date +'%m/%d/%Y - %H:%M:%S') -> CRIANDO BD $DB_NAME"
    docker exec -t postgres sh -c "psql -U postgres -c 'create database $DB_NAME;'"
    #Restore
    echo "$(date +'%m/%d/%Y - %H:%M:%S') -> RESTAURANDO $DB_NAME..."
    docker exec -t postgres sh -c 'pg_restore -U postgres -v --dbname '$DB_NAME' /opt/bkp/calima-testes.backup'
    #Ajustando BD
    ./script.sh $DB_NAME
    echo "$(date +'%m/%d/%Y - %H:%M:%S') -> Fim !!!"
else
    echo "$(date +'%m/%d/%Y - %H:%M:%S') -> Nome do banco não informado"
fi