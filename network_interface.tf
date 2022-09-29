
#network_interfaces
resource "aws_network_interface" "public-app-interface" {
    subnet_id       = aws_subnet.public-app-subnet.id
    security_groups = [
        aws_security_group.ssh-access.id, 
        aws_security_group.http-access.id,
        aws_security_group.outbound-all-access.id
    ]

    tags = {
        Name = "public-interface1"
    }
}

resource "aws_network_interface" "private-app-internal-interface" {
    subnet_id       = aws_subnet.private-internal-subnet.id
    security_groups = [
        aws_security_group.ssh-access.id, 
        aws_security_group.outbound-all-access.id
    ]

    tags = {
        Name = "private-interface1"
    }
}

resource "aws_network_interface" "private-db-internal-interface" {
    subnet_id       = aws_subnet.private-internal-subnet.id
    security_groups = [
        aws_security_group.ssh-access.id, 
        aws_security_group.mysql-access.id,
        aws_security_group.outbound-all-access.id
    ]

    tags = {
        Name = "private-db-internal-interface"
    }
}

resource "aws_network_interface" "private-db-interface" {
    subnet_id       = aws_subnet.private-db-subnet.id
    security_groups = [
        aws_security_group.outbound-all-access.id
    ]

    tags = {
        Name = "private-db-interface"
    }
}

