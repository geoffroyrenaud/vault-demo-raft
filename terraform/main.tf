provider "aws" {
  region = var.region
}


resource "tls_private_key" vault {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" vault {
  key_name   = var.myname
  public_key = tls_private_key.vault.public_key_openssh
}

resource "aws_security_group" "vault" {
  name        = var.myname
  description = "Allow SSH + Vault inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "ssh from mycidr"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.mycidr
  }

  ingress {
    description = "vault service from mycidr"
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = var.mycidr
  }

  ingress {
    description = "vault services between vault"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.myname
  }
}

module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = var.myname
  instance_count = 3

  ami                    = data.aws_ami.latest_centos_7.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.vault.key_name
  vpc_security_group_ids = [aws_security_group.vault.id]
  subnet_ids             = data.aws_subnet_ids.default.ids

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Stack       = var.myname
    AnsibleGrp = "vault_raft_servers"
  }
}
