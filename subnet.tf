# public_subnet_app
resource "aws_subnet" "public-app-subnet" {
    vpc_id = aws_vpc.mid-project.id
    cidr_block = "172.16.1.0/24"
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = "true"

    tags = {
        Name = "public-app-subnet"
    }
}

# public_subnet_ngw
resource "aws_subnet" "public-nat-subnet" {
    vpc_id = aws_vpc.mid-project.id
    cidr_block = "172.16.2.0/24"
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = "true"

    tags = {
        Name = "public-nat-subnet"
    }
}

# private_subnet_db
resource "aws_subnet" "private-db-subnet" {
    vpc_id = aws_vpc.mid-project.id
    cidr_block = "172.16.3.0/24"
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = "false"

    tags = {
        Name = "private-db-subnet"
    }
}

# private_subnet_app-db
resource "aws_subnet" "private-internal-subnet" {
    vpc_id = aws_vpc.mid-project.id
    cidr_block = "172.16.4.0/24"
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = "false"

    tags = {
        Name = "private-internal-subnet"
    }
}
