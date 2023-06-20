# ec2-setup

### TESTE CONHECIMENTO EM AWS

#### Conhecimentos necessários para realizar o teste:

 * Subir a EC2 e se conectar com ela via SSH
 * Configurar a rede dela - networking (VPC, Subnet e Security Group);
 * Criar uma redundância para o volume EBS (o volume também foi criado manualmente no console da AWS) da EC2 e criar uma imagem AMI (pode ser crua, pois não tem nenhum programa instalado, contudo me preocupei com a criação da mesma) customizada para a EC2;
 * Auto Scaling (Escala automática);


**Obs. Realizei o processo manualmente primeiro no console da AWS até para poder entender e fixar os conceitos dos serviços e processos da AWS incluídos no teste. Achei necessário, pois assim ficou mais leve para enfim subir em código Terraform. E como estou aprendendo, desenvolvendo em computação em nuvem achei melhor buscar entender o processo de forma manual mesmo.**

#### Além de ter que ir amadurecendo os conceitos:

**Redundância, tolerância a falha e alta disponibilidade** que são conceitos relacionados à confiabilidade e disponibilidade de sistemas e serviços da AWS. Embora estejam interconectados, cada um deles representa uma abordagem diferente para garantir a continuidade operacional. 

**Redundância**: A redundância é a prática de duplicar ou triplicar componentes críticos em um sistema para evitar a interrupção em caso de falha. Essa abordagem envolve a criação de cópias de hardware, software ou infraestrutura de rede para garantir que, se um componente falhar, outros estejam prontos para assumir sua função. A redundância pode ser implementada em diferentes níveis, como redundância de dados, redundância de hardware e redundância de rede.

**Tolerância a falha**: A tolerância a falha é a capacidade de um sistema continuar operando de maneira adequada, mesmo quando ocorrem falhas em seus componentes. Diferentemente da redundância, a tolerância a falha se concentra na capacidade do sistema de lidar com falhas e se recuperar delas, em vez de simplesmente duplicar os componentes. Ela pode ser alcançada por meio de técnicas como detecção de falhas, isolamento de falhas, recuperação automática e auto-reparo.

**Alta disponibilidade**: A alta disponibilidade refere-se à capacidade de um sistema ou serviço estar sempre disponível para uso, com um tempo mínimo de interrupção planejado ou não planejado. Isso envolve garantir que o sistema esteja sempre acessível aos usuários, mesmo durante atualizações, manutenções programadas, falhas de hardware ou outros eventos que possam interromper o funcionamento normal. A alta disponibilidade geralmente é alcançada por meio da combinação de redundância e tolerância a falha, além de práticas de monitoramento contínuo, balanceamento de carga e recuperação rápida. **Pensamos nisso foi devido duas AZs em que as sub-redes deverão ser provisionadas**. 


Em resumo, a **redundância** é uma abordagem que envolve a duplicação de componentes para evitar falhas, a **tolerância a falha** se concentra na capacidade de um sistema lidar com falhas e se recuperar delas, enquanto a **alta disponibilidade** é o resultado da combinação de redundância, tolerância a falha e outras práticas para garantir um tempo de inatividade mínimo e acesso constante ao sistema.
