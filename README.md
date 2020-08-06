# ambiente-projetus

##Pré requisitos:
`Docker ->` 
```sh 
sudo apt install docker.io docker-compose
sudo usermod -aG docker $USER
```
Atualizar constantes com os PATHS da sua máquina
Dar permissão de escrita as pastas necessarias caso houver erro de permissão

## Scripts

**Recomendo executar clone na sua pasta de desenvolvimento!!!**

###### Start
./start.sh  --> Constrói e sob os containers e serviços:
  * portainer -- Administrador de containers
  * postgres  -- banco de dados
  * pgAdmin4  -- cliente de banco dados
  * sonarQube -- Analisador de codigo 

###### Stop  
./stop.sh --> Para os servicos

###### Restore
./restore.sh --> Executa o a restauração do banco de dados
  * Baixar e deixar a base calima-testes.backup dentro do volume mapeado no docker-compose;
  * Informar o nome do banco **calima_testes** para sempre restaurar esse banco para testes;
  
  * Caso informar qualquer outro nome de banco o script irá na sua pasta de Downloads extrair o zip de backup, logo após abrirá uma janela para selecionar onde está o arquivo de backup para restauração.
