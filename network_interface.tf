
#network_interfaces
resource "aws_network_interface" "public-app-interface" {
    subnet_id       = aws_subnet.public-app-subnet.id
    security_groups = [
        aws_security_group.ssh-full-access.id,
        aws_security_group.http-full-access.id,
        aws_security_group.outbound-full-access.id
    ]

    tags = {
        Name = "public-app-interface"
    }
}

resource "aws_network_interface" "private-app-internal-interface" {
    subnet_id       = aws_subnet.private-internal-subnet.id
    security_groups = [
        aws_security_group.ssh-internal-access.id,
        aws_security_group.outbound-full-access.id
    ]

    tags = {
        Name = "private-app-internal-interface"
    }
}

resource "aws_network_interface" "private-db-internal-interface" {
    subnet_id       = aws_subnet.private-internal-subnet.id
    security_groups = [
        aws_security_group.ssh-internal-access.id, 
        aws_security_group.mysql-internal-access.id,
        aws_security_group.outbound-full-access.id
    ]

    tags = {
        Name = "private-db-internal-interface"
    }
}

resource "aws_network_interface" "private-db-interface" {
    subnet_id       = aws_subnet.private-db-subnet.id
    security_groups = [
        aws_security_group.outbound-full-access.id
    ]

    tags = {
        Name = "private-db-interface"
    }
}

