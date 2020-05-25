data "aws_ami" latest_amzn_linux_2 {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
