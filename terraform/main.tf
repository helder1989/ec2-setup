data "aws_ami" "HelderAmi" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "ami-035ee706ea00934cf" # AMI personalizada
  instance_type = "t3.micro"

  tags = {
    Name = "HelderTest"
  }
}