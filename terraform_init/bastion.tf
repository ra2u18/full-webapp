// Bastion AMI
data "aws_ami" "bastion" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

// Management Key Pair
resource "aws_key_pair" "management" {
  key_name   = "management"
  public_key = file(".ssh/test-terraform.pub")
}

resource "aws_security_group" "bastion_host" {
  name        = "bastion_sg_${var.vpc_name}"
  description = "Allow SSH from everywhere"
  vpc_id      = aws_vpc.management.id

  egress {
    from_port   = local.any_port
    to_port     = local.any_port
    protocol    = local.any_protocol
    cidr_blocks = local.all_ips
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = local.tcp_protocol
    cidr_blocks = local.all_ips
  }

  tags = {
    Name   = "bastion_sg_${var.vpc_name}"
    Author = var.author
  }
}

// Bastion instance
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.bastion.id
  instance_type               = "t2.micro" 
  key_name                    = aws_key_pair.management.id
  vpc_security_group_ids      = [aws_security_group.bastion_host.id]
  subnet_id                   = element(aws_subnet.public_subnets, 0).id
  associate_public_ip_address = true

  tags = {
    Name   = "bastion"
    Author = var.author
  }
}

locals {
  http_port    = 80
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}
