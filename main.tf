provider "aws" {
    # version = "-> 2.0"
    region = "ap-southeast-1"
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
}

resource "aws_vpc" "mid-project" {
    cidr_block = "172.16.0.0/16"

    tags = {
        Name = "mid-project-vpc"
    }
}

resource "aws_subnet" "subnet-1" {
    vpc_id = "${aws_vpc.mid-project.id}"
    cidr_block = "172.16.1.0/24"
    tags = {
        Name = "subnet-1"
    }
}

resource "aws_instance" "app-server" {
    ami = "ami-00e912d13fbb4f225"
    instance_type = "t2.micro"
    key_name = "mid-project-key"

    user_data = "${file("app-init.sh")}"

    tags = {
        Name = "mid-project-app-server"
    }
}
