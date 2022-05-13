resource "aws_security_group" "lb_sg"{
  }


resource "aws_vpc" "main"{
cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "gw" {
vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "example1"{
vpc_id = aws_vpc.main.id
cidr_block = "10.0.1.0/24"
availability_zone = "us-east-1a"
}

resource "aws_subnet" "example2"{
vpc_id = aws_vpc.main.id
cidr_block = "10.0.0.0/24"
availability_zone = "us-east-1b"
}
  
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.example1.id, aws_subnet.example2.id]


enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}