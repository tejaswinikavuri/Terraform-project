data "aws_ami" "ubuntu" {
most_recent = true
filter {
name = "name"
values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
}

filter {
name = "virtualization-type"
values = ["hvm"]
}

owners = ["099720109477"] # Canonical
}



resource "aws_launch_configuration" "as_conf" {
name_prefix = "terraform-lc-example-"
image_id = data.aws_ami.ubuntu.id
instance_type = "t2.micro"
}

resource "aws_vpc" "main"{
cidr_block = "10.0.0.0/16"
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




resource "aws_autoscaling_group""bar"{
name = "foobar3-terraform-test"
max_size = 1
min_size = 1
health_check_grace_period = 300
health_check_type = "EC2"
desired_capacity = 1
force_delete = true
#placement_group = aws_placement_group.test.id
launch_configuration = aws_launch_configuration.as_conf.name
vpc_zone_identifier = [aws_subnet.example1.id, aws_subnet.example2.id]
}

resource "aws_iam_role" "test_role" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
  Version = "2012-10-17",
  Statement = [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "autoscaling.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})

tags = {
key = "foo"
value = "bar"
propagate_at_launch = true
}
}
