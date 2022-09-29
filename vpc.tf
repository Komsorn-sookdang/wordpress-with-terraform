provider "aws" {
    # version = "-> 2.0"
    region = var.AWS_SECRET_REGION
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
}

resource "aws_vpc" "mid-project" {
    cidr_block = "172.16.0.0/16"

    tags = {
        Name = "mid-project-vpc"
    }
}
