#!/bin/bash
# scriptStatusApache.sh

# Váriaveis para armazenar a data e hora e o status do serviço httpd
DATA=`date +'%d/%m/%Y as %T'`
STATUSAPACHE=$(systemctl status httpd)

# Condicional para checar se o Apache está ativo ou não e imprimir resultado no arquivo gerado
if [[ "${STATUSAPACHE}" == *"active (running)"* ]]
then
        echo "O Apache está online - "$DATA >> /nfs-atividade/Vandielson/servico_apache_online.txt
else
 
        echo "O Apache está offline - "$DATA >> /nfs-atividade/Vandielson/servico_apache_offline.txt

fi
