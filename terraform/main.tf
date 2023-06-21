############################ VARIÁVEIS GLOBAIS ##############################
variable "AWS_TAGS" {
  type = map(string)
  default = {
      "Project" = "in8-ec2-setup"
  }
}

variable "PROJECT_NAME" {
  default = "in8-ec2-setup"
}

############################ CONFIGURAÇÃO DE REDE DA EC2 ##############################

resource "aws_vpc" "main-vpc" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "${var.PROJECT_NAME}-main-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = "172.16.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true # esse parâmetro garante que a subnet seja pública
  tags = {
    Name = "${var.PROJECT_NAME}-public-subnet"
  }
}

#tabelas de rota da subnet pública
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name = "${var.PROJECT_NAME}-public-route-table"
  }
}
# associa a tabela rota e a subnet publica
resource "aws_route_table_association" "route-table-association" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "${var.PROJECT_NAME}-internet-gateway"
  }
}

# cria rota entre a subnet e o internet gateway
resource "aws_route" "igw" {
  route_table_id = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}


# security group da instância
resource "aws_security_group" "ec2-security-group" {
  name = "${var.PROJECT_NAME}-ec2-security-group"
  description = "Allow TLS inbound traffic"
  vpc_id = aws_vpc.main-vpc.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.PROJECT_NAME}-ec2-security-group"
  }
}
resource "aws_security_group_rule" "my-ip" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["187.108.55.73/32"]
  security_group_id = aws_security_group.ec2-security-group.id
}


############################ CONFIGURAÇÃO DA EC2 ##############################

resource "aws_instance" "in8-ec2-test" {
  ami = "ami-035ee706ea00934cf" # ID da minha imagem customizada
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public-subnet.id
  key_name = "HelderEc2-setup"

  vpc_security_group_ids = [aws_security_group.ec2-security-group.id]

  tags = {
    Name = "${var.PROJECT_NAME}-ec2"
  }
}