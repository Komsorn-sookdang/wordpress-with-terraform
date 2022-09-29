#eip
resource "aws_eip" "app-eip" {
    vpc                       = true
    network_interface         = aws_network_interface.public-app-interface.id

    tags = {
        Name = "app-eip"
    }
}

resource "aws_eip" "nat-eip" {
    vpc                       = true

    tags = {
        Name = "nat-eip"
    }
}

