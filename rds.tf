provider "aws"{
  region = "us-east-1"
  access_key = "******************************"
  secret_key = "******************************"            
}


resource "aws_db_instance" "default" {

  identifier = "mydatabase1"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t2.micro"
  db_name              = "mydatabase"
  username             = "mydatabase"
  password             = "*************"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

}