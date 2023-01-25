#!/bin/bash
# scriptStatusApache.sh

# Váriaveis para armazenar a data e a hora e o status do serviço online
DATA=`date +'%d/%m/%Y as %T'`
STATUSAPACHE=$(systemctl status httpd)

# Condicional para checar se o Apache está ativo ou não e imprimir resultado no arquivo gerado
if [[ "${STATUSAPACHE}" == *"active (running)"* ]]
then
        echo "O Apache está online - "$DATA >> /nfs-atividade/Vandielson/servico_online.txt
else
 
        echo "O Apache está offline - "$DATA >> /nfs-atividade/Vandielson/servico_offline.txt

fi
