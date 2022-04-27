resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "vpc-terraform"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "subnet-terraform"
  }
}


resource "aws_internet_gateway" "internet_gtw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "internet-gtw-terraform"
  }
}


resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gtw.id
  }


  tags = {
    Name = "route-table-terraform"
  }
}


resource "aws_main_route_table_association" "rta" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.route_table.id
}


resource "aws_security_group" "security_group" {
  name   = "security-group-terraform"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}