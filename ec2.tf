provider "aws" {
  region  = "us-east-1"
  access_key = "************************"
  secret_key = "******************************"            
}



resource "aws_instance" "my-first-server" {
  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"

}
# resource "<provider>_<resource_type>" "name"{
#    config options......
#    Key= "value"
#   key2= "another value"
# }