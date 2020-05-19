# ambiente-projetus

##Pré requisitos:
`Docker ->` 
```sh 
sudo apt install docker.io docker-compose
sudo usermod -aG docker $USER```

## Scripts          
*Recomendo executar clone na sua pasta de desenvolvimento!!!
### Start
./start.sh  --> Constrói e sob os containers e serviços:
  portainer -- Administrador de containers
  postgres  -- banco de dados
  pgAdmin4  -- cliente de banco dados

### Stop  
./stop.sh --> Para os servicos

### Restore
./restore.sh --> Executa o a restauração do banco de dados
  Baixar e deixar a base calima-testes.backup dentro do volume mapeado no docker-compose;
  Informar o nome do banco calima_testes para sempre restaurar esse banco para testes;
  
  Caso informar qualquer outro nome de banco abrirá uma janela para selecionar onde está o arquivo de backup para restauração.
