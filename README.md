<h1>Atividade Prática Sobre AWS e Linux - PB COMPASS.UOL</h1>

> Status da Atividade: :warning: (Em desenvolvimento)

### Tópicos

* [Descrição do atividade](#descrição-da-atividade)

* [Realeses](#realeses)

* [Criação de uma instância EC2](#criação-de-uma-intância-ec2)

### Descrição da atividade

Este repósitorio tem como objetivo descrever as etapas do processo de criação de uma instância EC2 com as seguintes configurações:

* Sistema operacional Amazon Linux 2 (Família t3.small, 16 GB SSD);
* Associar 1 elastic IP e anexar à instância EC2;
* Realizar a liberação das portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP).

Além disso, apresentar a configuração no Linux, realizando os seguintes passos:

* O acesso a um NFS server;
* Criar um diretório dentro do filesystem do NFS;
* Realizar a instalação do Apache;
* Criar um script para enviar um arquivo de status do serviço do Apache para dentro do diretório no NFS.


### Realeses

* Realese v1.0

:heavy_check_mark: Instância Linux criada

* Realese v1.1

>

...

### Criação de uma instância EC2

* Para criação da Instância, inicialmente é necessário criar uma conta AWS. Após a criação, vá até o serviço EC2 e no menu lateral esquerdo clique em Instances. Dentro da aba Instances, clique em Launch instances para criar um nova instância e selecione as configurações de acordo com as necessidades do projeto, seguindo a seguinte ordem:

1. Name and tags - Aqui são adicionadas as tags do projeto. São essenciais para identificação dos recursos;

2. AMI - Selecione a imagem do sistema operacional que deseja virtualizar (Ex.: Amazon Linux 2);

3. Instance type - Selecione o tipo de instância (Ex.: t3.small);

4. Key pair - Realize a criação de um chave de segurança e faça o download da mesma. Com ela você consegue realizar o login de maneira remota via SSH ou Putty;

5. Network settindgs - Nesta seção você seleciona o VPC, a Subnet, habilita a criação de um IP público e cria ou seleciona um grupo de segurança;

6. Configure storage - Configuração do seu volume de armazenamento (Ex.: 16 GB do tipo gp2);

7. Clique no botão Lauch instance para finalizar a criação da instância.

* Após o fim da criação da instância é necessário realizar a reserva de um IP elástico. Vá até o menu lateral e clique na opção Elastic IPs. Dentro da aba, clique em Allocate Elastic IP address, e faça a seguinte seleção:

1. Network Border Group - selecione a região na qual quer reservar o IP e é necessário que seja a mesma da instância;

2. Public IPv4 address pool - selecione a primeira opção (Amazon's pool of IPv4 address);

3. Adicione as tags e clique em Allocate;

4. Por fim, dentro da aba Elastic IP addresses selecione o IP criado clique em Actions e faça a associação com a instância clicando em Associate Elastic IP address.

* Para finalizar, no menu lateral clique em Segurity Groups e faça a edição das regras de entrada selecionado o seu grupo de segurança e clicando em Inbound rules. Adicione as portas necessárias para o que deseja realizar ou siga o padrão da atividade.




















