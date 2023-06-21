# ec2-setup

## TESTE CONHECIMENTO EM AWS

Sobre o projeto, realizei o processo manualmente primeiro no console da AWS até para poder entender e fixar os conceitos dos serviços e processos da AWS incluídos no teste. Achei necessário, pois assim ficou mais leve para enfim subir em código Terraform. E como estou aprendendo, desenvolvendo em computação em nuvem achei melhor buscar entender o processo de forma manual mesmo.** Contudo estudando sobre o **terraform** deu pra entender que o mesmo é uma ferramente potente de automação de infraestrutura para provisionar e gerenciar recursos. **Com o terraform podemos criar um conjunto de arquivos, criar um bloco de código, executar códigos em várias contas da AWS ao mesmo tempo, além de conseguir replicar o código. Exemplo de caso de uso: Imagine que construir uma casa top, porém não tem projeto. Ou seja, nesse caso você não consegue replicar, construir outra casa nos mesmos moldes e padrão da primeira (isso ocorreu quando usei o console da AWS). O Terraform resolve isso! Pois ele viabiliza projetos, documentos, desenho de arquitetura via código. Com o terraform conseguimos gerenciar a nossa infraestrutura no provedor aws por exemplo.**

#### Além de ter que ir amadurecendo os conceitos:

**Redundância, tolerância a falha e alta disponibilidade** que são conceitos relacionados à confiabilidade e disponibilidade de sistemas e serviços da AWS. Embora estejam interconectados, cada um deles representa uma abordagem diferente para garantir a continuidade operacional. 

**Redundância**: A redundância é a prática de duplicar ou triplicar componentes críticos em um sistema para evitar a interrupção em caso de falha. Essa abordagem envolve a criação de cópias de hardware, software ou infraestrutura de rede para garantir que, se um componente falhar, outros estejam prontos para assumir sua função. A redundância pode ser implementada em diferentes níveis, como redundância de dados, redundância de hardware e redundância de rede.

**Tolerância a falha**: A tolerância a falha é a capacidade de um sistema continuar operando de maneira adequada, mesmo quando ocorrem falhas em seus componentes. Diferentemente da redundância, a tolerância a falha se concentra na capacidade do sistema de lidar com falhas e se recuperar delas, em vez de simplesmente duplicar os componentes. Ela pode ser alcançada por meio de técnicas como detecção de falhas, isolamento de falhas, recuperação automática e auto-reparo.

**Alta disponibilidade**: A alta disponibilidade refere-se à capacidade de um sistema ou serviço estar sempre disponível para uso, com um tempo mínimo de interrupção planejado ou não planejado. Isso envolve garantir que o sistema esteja sempre acessível aos usuários, mesmo durante atualizações, manutenções programadas, falhas de hardware ou outros eventos que possam interromper o funcionamento normal. A alta disponibilidade geralmente é alcançada por meio da combinação de redundância e tolerância a falha, além de práticas de monitoramento contínuo, balanceamento de carga e recuperação rápida. **Pensamos nisso foi devido duas AZs em que as sub-redes deverão ser provisionadas**. 


Em resumo, a **redundância** é uma abordagem que envolve a duplicação de componentes para evitar falhas, a **tolerância a falha** se concentra na capacidade de um sistema lidar com falhas e se recuperar delas, enquanto a **alta disponibilidade** é o resultado da combinação de redundância, tolerância a falha e outras práticas para garantir um tempo de inatividade mínimo e acesso constante ao sistema.

 
#### O código criado é um arquivo de configuração do Terraform para provisionar recursos da AWS, como uma VPC, subrede, tabela de rota, gateway de internet, grupo de segurança e uma instância EC2:

**A seguir será apresentado uma explicação básica de cada recurso no código:**

1) Variáveis ​​globais: A configuração começa definindo duas variáveis ​​globais: AWS_TAGSe PROJECT_NAME. A variável AWS_TAGSé um mapa que define as tags da AWS para o recurso criado. Uma variável PROJECT_NAMEdefine o nome do projeto.

2) Configuração de Rede da EC2:

Em seguida, são definidos os recursos de rede necessários para a instância EC2. O recurso aws_vpccria uma VPC (Virtual Private Cloud) com o bloco CIDR "172.16.0.0/16". A tag do recurso é definida usando o valor da variável PROJECT_NAME.

O recurso aws_subnetcria uma sub-rede pública na VPC criada anteriormente. A sub-rede tem o bloco CIDR "172.16.0.0/24" e está na zona de disponibilidade "us-east-1a". Uma propriedade map_public_ip_on_launché definida como true para garantir que uma sub-rede seja pública. A tag do recurso é definida usando o valor da variável PROJECT_NAME.

Em seguida, são criadas as tabelas de rota e associações necessárias para a sub-rede pública. O recurso aws_route_tablecria uma tabela de rota na VPC. A tag do recurso é definida usando o valor da variável PROJECT_NAME. O recurso aws_route_table_associationassocia a tabela de rota criada à sub-rede pública.

O recurso aws_internet_gatewaycria um gateway de internet na VPC. A tag do recurso é definida usando o valor da variável PROJECT_NAME.

Em seguida, é criada uma rota na tabela de rota da subnet pública, que direciona todo o tráfego (CIDR "0.0.0.0/0") para o internet gateway.

3) Grupo de Segurança da Instância EC2:

O recurso aws_security_group cria um grupo de segurança para a instância EC2. O grupo de segurança permite todo o tráfego de saída (egress) e permite o tráfego SSH (porta 22) apenas a partir do endereço IP específico "187.108.55.73/32". A tag do recurso é definida usando o valor da variável PROJECT_NAME.

4) Confuguração da instância EC2:

Finalmente, o recurso aws_instancecria a instância EC2. A AMI (Amazon Machine Image) é definida como "ami-035ee706ea00934cf", o tipo de instância é "t3.micro", a subnet é definida como a subnet pública criada anteriormente e a chave de acesso é definida como "AcessoHelder". O grupo de segurança da instância é definido como o grupo de segurança criado anteriormente. A tag da instância é definida usando o valor da variável PROJECT_NAME.

Esse código cria uma infraestrutura básica para uma instância EC2 com uma VPC, subnet pública, tabela de rota, gateway de internet e grupo de segurança. Certifique-se de substituir os valores das variáveis ​​e recursos de acordo com suas necessidades.


**Observação**: Verificando a documentação oficial do terraform (https://www.terraform.io/), cheguei a conclusão que nesse universo o que provisionei nesse projeto é algo mais básico, porém vi que tem provisionamentos mais complexos realizado via **Terraform**


** Para eliminar, deletar tudo o que criamos, basta rodar no terminal: **terraform destroy**













#### Conhecimentos necessários para realizar o teste:

 * Subir a EC2 e se conectar com ela via SSH
 * Configurar a rede dela - networking (VPC, Subnet e Security Group);
 * Criar uma redundância para o volume EBS (o volume também foi criado manualmente no console da AWS) da EC2 e criar uma imagem AMI (pode ser crua, pois não tem nenhum programa instalado, contudo me preocupei com a criação da mesma) customizada para a EC2;
 * Auto Scaling (Escala automática);



![utils/ec2-network.png](utils/ec2-network.png.jpg) # Estamos implementação conforme
