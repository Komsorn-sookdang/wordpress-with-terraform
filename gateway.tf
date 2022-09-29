# internet gateway
resource "aws_internet_gateway" "main-gateway" {
    vpc_id = aws_vpc.mid-project.id

    tags = {
        Name = "main-internet-gateway"
    }
}

# NAT gateway
resource "aws_nat_gateway" "nat-gateway" {
    allocation_id = aws_eip.nat-eip.id
    subnet_id     = aws_subnet.public-nat-subnet.id

    tags = {
        Name = "nat-gateway"
    }
}