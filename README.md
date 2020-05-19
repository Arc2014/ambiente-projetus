# ambiente-projetus

Pré requisitos:
Docker -> sudo apt install docker.io docker-compose
          sudo usermod -aG docker $USER
          
!!!Recomendo executar clone na sua pasta de desenvolvimento!!!

./start.sh --> Constrói e sob os containers e serviços:
  portainer -- Administrador de containers
  postgres  -- banco de dados
  pgAdmin4  -- cliente de banco dados
  
./stop.sh --> Para servicos

./restore.sh --> Executa o a restauração do banco de dados
  Baixar e deixar a base calima-testes.backup dentro do volume mapeado no docker-compose;
  Informar o nome do banco calima_testes para sempre restaurar esse banco para testes;
  
  Caso informar qualquer outro nome de banco abrirá uma janela para selecionar onde está o arquivo de backup para restauração.
