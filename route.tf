# public-app-route-table
resource "aws_route_table" "public-app-route-table" {
    vpc_id = aws_vpc.mid-project.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-gateway.id
    }
    tags = {
        Name = "public-app-route-table"
    }
}

# private-db-route-table
resource "aws_route_table" "db-route-table" {
    vpc_id = aws_vpc.mid-project.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gateway.id
    }

    tags = {
        Name = "db-route-table"
    }
}


#route_table_association
resource "aws_route_table_association" "public-app-router" {
    subnet_id      = aws_subnet.public-app-subnet.id
    route_table_id = aws_route_table.public-app-route-table.id
}

resource "aws_route_table_association" "public-nat-to-gateway" {
    subnet_id      = aws_subnet.public-nat-subnet.id
    route_table_id = aws_route_table.public-app-route-table.id
}

resource "aws_route_table_association" "route-table3" {
    subnet_id      = aws_subnet.private-db-subnet.id
    route_table_id = aws_route_table.db-route-table.id
}


