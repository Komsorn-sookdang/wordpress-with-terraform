provider "aws" {
    # version = "-> 2.0"
    region = "ap-southeast-1"
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
}

resource "aws_vpc" "mid-project" {
    cidr_block = "172.16.0.0/16"

    tags = {
        Name = "mid-project"
    }
}

resource "aws_instance" "web-server" {
    ami = "ami-00e912d13fbb4f225"
    instance_type = "t2.micro"
    key_name = "mid-project-key"

    user_data = <<-EOF
                sudo apt update -y
                EOF

    tags = {
        Name = "mid-project-web-server"
    }
}
