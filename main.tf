provider "aws" {
  region = "eu-central-1"
}

# Define the EC2 instance to deploy the app on
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "mykey"
  security_groups = ["default"]
}

# Define the security group to allow inbound traffic to the app
resource "aws_security_group" "app_sg" {
  name_prefix = "app_sg"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define the script to provision the instance with the app
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "mykey"
  security_groups = ["${aws_security_group.app_sg.name}"]
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y python3-pip
              pip3 install flask
              python3 .project-backend1/simpleflaskapp.py #CHECK IF PATH IS OK!!!
              EOF
}