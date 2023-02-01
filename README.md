<h1>Atividade Prática Sobre AWS e Linux - PB COMPASS.UOL</h1>

> Status da Atividade: :heavy_check_mark: (concluída)

> Atividade desenvolvida por: Vandielson Tenório Feitosa de Assis

## Tópicos

* [Descrição da atividade](#descrição-da-atividade)

* [Criação de uma instância EC2](#criação-de-uma-intância-ec2)

* [Configuração do NFS](#configuração-do-nfs)

* [Criação do diretório dentro do NFS server](#criação-do-diretório-do-nfs-server)

* [Instalação e ativação do Apache](#configuração-e-ativação-do-apache)

* [Criação e automação do script de verificação de status do Apache](#criação-e-automação-do-script-de-verificação-do-status-do-apache)

* [Links de apoio](#links-de-apoio)

## Descrição da atividade

Este repósitorio tem como objetivo apresentar as etapas do processo de criação de uma instância EC2 com as seguintes configurações:

* Sistema operacional Amazon Linux 2 (Família t3.small, 16 GB SSD);
* Associar 1 elastic IP e anexar à instância EC2;
* Realizar a liberação das portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP).

Além disso, apresentar a configuração no Linux, realizando os seguintes passos:

* O acesso a um NFS server;
* Criar um diretório dentro do filesystem do NFS;
* Realizar a instalação do Apache;
* Criar um script para enviar um arquivo de status do serviço do Apache para dentro do diretório no NFS.

## Criação de uma instância EC2

Para criação da Instância, inicialmente é necessário criar uma conta AWS. Após a criação, vá até o serviço EC2 e no menu lateral esquerdo clique em Instances. Dentro da aba Instances, clique em Launch instances para criar um nova instância e selecione as configurações de acordo com as necessidades do projeto, seguindo a seguinte ordem:

1. Name and tags - Adicione as tags do projeto. São essenciais para identificação e gerenciamento dos recursos;

2. AMI - Selecione a imagem do sistema operacional que deseja virtualizar (Ex.: Amazon Linux 2);

3. Instance type - Selecione o tipo de instância (Ex.: t3.small);

4. Key pair - Realize a criação de uma chave de segurança e faça o download da mesma. Com ela é feito o login de maneira remota via SSH ou Putty;

5. Network settings - Nesta seção você seleciona o VPC, a Subnet, habilita a criação de um IP público e seleciona um grupo de segurança;

6. Configure storage - Configuração do seu volume de armazenamento (Ex.: 16 GB do tipo gp2);

7. Clique no botão Lauch instance para finalizar a criação da instância.

Após o fim da criação da instância é necessário realizar a reserva de um IP elástico. Vá até o menu lateral e clique na opção Elastic IPs. Dentro da aba, clique em Allocate Elastic IP address e faça a seguinte seleção:

1. Network Border Group - selecione a região na qual quer reservar o IP e é necessário que seja a mesma da instância;

2. Public IPv4 address pool - selecione a primeira opção (Amazon's pool of IPv4 address);

3. Adicione as tags e clique em Allocate;

4. Por fim, dentro da aba Elastic IP addresses selecione o IP criado clique em Actions e faça a associação com a instância clicando em Associate Elastic IP address.

5. Para finalizar, no menu lateral clique em Segurity Groups e faça a edição das regras de entrada selecionando o seu grupo de segurança e clicando em Inbound rules. Adicione as portas necessárias para o que deseja realizar ou siga o padrão da atividade.

## Configuração do NFS

* Após a criação da instância, faça o login remotamente atráves do terminal da sua máquina física via SSH com o seguinte comando:

```
ssh -i /diretório/chavedeacesso.pem ec2-user@IP-público
```

* Feito o login na máquina, mude para usuário root com o comando:

```
sudo su
``` 

* Dentro do diretório raiz crie um diretório para armazenar o ponto de montagem do NFS.

```
mkdir <nome-do-diretório>
```

* Os pacotes amazon-efs-utils e nfs-utils vem instalados na Amazon Linux 2. Caso não, realize os seguintes comandos:

```
yum install -y amazon-efs-utils

yum install nfs-utils
 
systemctl start nfs-utils

systemctl enable nfs-utils
```

* Agora, dentro do diretório criado faça a montagem do NFS com o comando:

```
mount -t nfs <DNS>:/ <diretório-criado>
```

* Por fim, vá até o diretório etc e abra o arquivo fstab. O arquivo armazena a configuração de quais dispositivos devem ser montados e qual o ponto de montagem de cada um na carga do sistema operacional, mesmo dispositivos locais e remotos. Dentro do arquivo fstab, insira o seguinte comando:

```
<DNS ou IP>:/ /nfs nfs defaults 0 0
```

* Resumindo o comando, O primeiro parâmetro é o endereço do NFS server + diretório, o segundo é o diretório onde será realizada a montagem, depois vem o tipo de serviço que é o nfs, a especificação de que será executado por padrão (defaults), o primeiro zero representa que não será realizado nenhum backup e o segundo zero é dedicado a checagens de disco com o utilitário fsck (file system check). Assim, sempre que o máquina for reinicializada a montegem do nfs será feita.

## Criação do diretório dentro do NFS server

* Dentro do NFS server crie o diretório com seu nome.

```
mkdir seu-nome
```

## Instalação e ativação do Apache

* Inicialmente, realize a instalação do Apache:

```
yum install httpd
```

* Assim que a instalção finalizar, inicie e ative o serviço.

```
systemctl start httpd

systemctl enable httpd
```

* Por fim, verifique se o Apache foi iniciado e ativado.

```
systemctl status httpd
```

## Criação e automação do script de verificação de status do Apache

Este script tem por finalidade checar se o serviço do Apache está ativo ou não e criar um arquivo personalizado informando a data, a hora e o status do serviço.

* No terminal digite o comando abaixo para criar um arquivo:

```
vim nome-do-arquivo.sh
```

* Abaixo estão todos os comandos que devem ser inseridos dentro do arquivo criado:

```
#!/bin/bash
# Arquivos executáveis devem sempre começar com o barra bin barra bash
# nome-do-arquivo.sh


# Variável para armazenar a data e a hora e o status do serviço
DATA=`date +'%d/%m/%Y as %T'`
STATUS=$(systemctl status httpd)


# Condicional para checar se o Apache está ativo ou não e imprimir resultado no arquivo gerado
# Se a saída da variável for igual a trecho "active (running)" escreva que o Apache está online
# Se não, escreva o Ache está offline
if [[ "${STATUS}" == *"active (running)"* ]]
then
        echo "O Apache está online - "$DATA >> /diretório-criado/seu-nome/servico_online.txt
else

        echo "O Apache está offline - "$DATA >> /diretório-criado/seu-nome/servico_offline.txt

fi
```

* Ao finalizar o script, salve o arquivo e realize o comando abaixo para torná-lo executável:

```
chmod +x nome-do-arquivo.sh
```

* Agora, aplique as seguintes permissões dentro da pasta com seu nome criada no NFS:

```
chmod 775 /diretório-criado/seu-nome/
chmod 775 /diretório-criado/seu-nome/*
```

* Após isso será necessário agendar a execução do scrip no crontab. Vá até o diretório etc e abra o arquivo crontab e adicione o seguinte script:

```
*/5 * * * * bash /nome-do-script.sh
```

Finalizando todo o procedimento descrito, a cada 5 minutos o script vai ser executado e irá realizar a verificação do status do serviço Apache e emitirá uma mensagem que será armazenada dentro de um arquivo de texto que será ficará salvo no diretório criado dentro do filesystem do NFS.  

## Links de apoio

* https://docs.aws.amazon.com/pt_br/AWSEC2/latest/UserGuide/EC2_GetStarted.html
* https://docs.aws.amazon.com/pt_br/efs/latest/ug/mounting-fs-old.html#mounting-fs-install-nfsclient
* https://docs.aws.amazon.com/pt_br/efs/latest/ug/mounting-fs-mount-helper-ec2-linux.html
* https://stackoverflow.com/questions/36263335/how-to-check-whether-mongodb-is-running-from-a-shell-script
