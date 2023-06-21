# ec2-setup

#### TESTE CONHECIMENTO EM AWS

Sobre o projeto, inicialmente executei o processo manualmente através do console da AWS. Isso me permitiu compreender e solidificar os conceitos dos serviços e processos incluídos no teste. Considero essa etapa importante, pois me instruí uma base sólida para posteriormente migrar para a abordagem em código utilizando o Terraform.

**Ao estudar o Terraform, pude compreender que essa ferramenta é uma poderosa solução para automação de infraestrutura, permitindo o provisionamento e gerenciamento de recursos de forma eficiente. Com o Terraform, é possível criar conjuntos de arquivos contendo blocos de código que podem ser executados em várias contas da AWS simultaneamente, além de facilitar a replicação do código.**

Para ilustrar um caso de uso, podemos imaginar a construção de uma casa personalizada de alta qualidade, porém sem um projeto projetado. Nesse cenário, seria difícil replicar a construção de uma segunda casa com as mesmas características e padrões da primeira (essa foi a limitação que encontrou ao utilizar o console da AWS). No entanto, o Terraform resolve esse problema, viabilizando a criação de projetos, documentos e arquiteturas por meio de código. Com o Terraform, é possível gerenciar de forma eficiente a infraestrutura em provedores como a AWS.

**Dessa forma, ao utilizar o Terraform, é possível obter uma abordagem mais automatizada, consistente e escalável para o provisionamento e gerenciamento dos recursos de infraestrutura na AWS.**

#### Além de ter que ir amadurecendo os conceitos:

**Redundância**, **tolerância a falhas** e **alta disponibilidade** são conceitos essenciais relacionados à confiabilidade e disponibilidade de sistemas e serviços na AWS. Embora estejam interconectados, cada um deles representa uma abordagem distinta para assegurar a continuidade operacional.

A **redundância** refere-se à duplicação de componentes críticos do sistema, como servidores, armazenamento e redes, a fim de evitar pontos únicos de falha. Ao utilizar a redundância, caso um componente falhe, outros assumem uma carga de trabalho, garantindo a continuidade do serviço.

A **tolerância a falhas**, por sua vez, está relacionada à capacidade do sistema de continuar funcionando mesmo quando ocorrem falhas em seus componentes. Isso envolve a implementação de estratégias e controle que permitem a detecção de falhas, a recuperação automática e a continuidade operacional sem manutenção para os usuários.

A **alta disponibilidade** é o objetivo de manter os sistemas e serviços em funcionamento contínuo, com pouca ou nenhuma interrupção. Isso é alcançado por meio da combinação de redundância, tolerância a falhas, monitoramento contínuo e práticas de projeto e configuração ajustadas.

Em conjunto, esses conceitos de trabalho para garantir que os sistemas e serviços da AWS permaneçam, estejam prontos para lidar com falhas e estivessem disponíveis mesmo em cenários adversos. Ao implementar estratégias e arquiteturas que abordam a redundância, tolerância a falhas e alta disponibilidade, as organizações podem garantir a resiliência de suas aplicações e a satisfação dos usuários finais.


#### O código criado é um arquivo de configuração do Terraform para provisionar recursos da AWS, como uma VPC, subrede, tabela de rota, gateway de internet, grupo de segurança e uma instância EC2:

**A seguir será apresentado uma explicação básica de cada recurso no código:**

**1)** Variáveis globais: A configuração começa definindo duas variáveis globais: **AWS_TAGS e PROJECT_NAME**. A variável **AWS_TAGS** é um mapa que define as tags da AWS para os recursos criados. A variável **PROJECT_NAME** define o nome do projeto.

**2)** Configuração de Rede da EC2:

Em seguida, são definidos os recursos de rede necessários para a instância EC2. O recurso aws_vpc cria uma VPC (Virtual Private Cloud) com o bloco CIDR "172.16.0.0/16". A tag do recurso é definida usando o valor da variável **PROJECT_NAME**.

O recurso **aws_subnet** cria uma sub-rede pública na VPC criada anteriormente. A sub-rede possui o bloco CIDR "172.16.0.0/24" e está na zona de disponibilidade "us-east-1a". A propriedade **map_public_ip_on_launch** é definida como true para garantir que a sub-rede seja pública. A tag do recurso é definida usando o valor da variável **PROJECT_NAME**.

Em seguida, são criadas as tabelas de rota e associações necessárias para a sub-rede pública. O recurso **aws_route_table** cria uma tabela de rota na VPC. A tag do recurso é definida usando o valor da variável **PROJECT_NAME**. O recurso aws_route_table_association associa a tabela de rota criada à sub-rede pública.

O recurso **aws_internet_gateway** cria um gateway de internet na VPC. A tag do recurso é definida usando o valor da variável **PROJECT_NAME**.

Em seguida, é criada uma rota na tabela de rota da sub-rede pública, que direciona todo o tráfego (CIDR "0.0.0.0/0") para o internet gateway.

**3)** Grupo de Segurança da Instância EC2:

O recurso **aws_security_group** cria um grupo de segurança para a instância EC2. O grupo de segurança permite todo o tráfego de saída (egress) e permite o tráfego **SSH** (porta 22) apenas a partir do endereço IP específico "187.108.55.73/32". A tag do recurso é definida usando o valor da variável **PROJECT_NAME**.

**4)** Confuguração da instância EC2:

Finalmente, o recurso **aws_instance** cria a instância EC2. A AMI (Amazon Machine Image) é definida como **"ami-035ee706ea00934cf"** (imagem customizada que criei), o tipo de instância é "t3.micro", a subnet é definida como a sub-rede pública criada anteriormente e a chave de acesso é definida como **"AcessoHelder"**. O grupo de segurança da instância é definido como o grupo de segurança criado anteriormente. A tag da instância é definida usando o valor da variável **PROJECT_NAME**.

Este código cria uma infraestrutura básica para uma instância EC2, incluindo uma VPC, sub-rede pública, tabela de rota, gateway de internet e grupo de segurança. 


Observação: Ao verificar a documentação oficial do **Terraform** (https://www.terraform.io/), cheguei à conclusão de que o que provisionei neste projeto é algo mais básico. No entanto, observei que o Terraform permite realizar provisionamentos mais complexos.

Para eliminar e deletar todos os recursos que foram criados, basta executar o comando **terraform destroy** no terminal. Isso irá desfazer todas as alterações feitas na infraestrutura.


![ec2-network.png](ec2-network) # Estamos implementação conforme a ilustração. 



#### Conhecimentos necessários para realizar o teste:

 * Subir a EC2 e se conectar com ela via SSH
 * Configurar a rede dela - networking (VPC, Subnet e Security Group);
 * Criar uma redundância para o volume EBS (o volume também foi criado manualmente no console da AWS) da EC2 e criar uma imagem AMI (pode ser crua, pois não tem nenhum programa instalado, contudo me preocupei com a criação da mesma) customizada para a EC2;
 * Auto Scaling (Escala automática);







