provider "aws" {
    # version = "-> 2.0"
    region = var.region
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
}

resource "aws_vpc" "mid-project" {
    cidr_block = var.vpc_subnet

    tags = {
        Name = "mid-project-vpc"
    }
}
