!/bin/bash

#### compacta www
docker exec -ti current_wordpress_1 zip -r -9 wpv_backup.zip /var/www/
#### copia www para diretorio atual da maquina
docker cp current_wordpress_1:/var/www/html/wpv_backup.zip ./
#### remove zip temporario no container
docker exec -ti current_wordpress_1 rm /var/www/html/wpv_backup.zip

docker cp current_db_1:/tmp/wpvdb_backup.sql ./
docker exec -ti current_db_1 rm /tmp/wpvdb_backup.sql

