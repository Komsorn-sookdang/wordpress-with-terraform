data "template_file" "db-server-init" {
    template = file("./db-server-init.tpl")
    vars = {
        db_username      = var.database_user
        db_user_password = var.database_password
        db_name          = var.database_name
    }
}

resource "aws_instance" "db-server" {
    ami = "ami-00e912d13fbb4f225"
    instance_type = "t2.micro"
    key_name = "mid-project-key"

    user_data = data.template_file.db-server-init.rendered
    
    network_interface {
        network_interface_id = aws_network_interface.private-db-internal-interface.id
        device_index = 1
    }

    network_interface {
        network_interface_id = aws_network_interface.private-db-interface.id
        device_index = 0
    }

    tags = {
        Name = "mid-project-db-server"
    }
}

data "template_file" "app-server-init" {
    template = file("./app-server-init.tpl")
    vars = {
        db_username      = var.database_user
        db_user_password = var.database_password
        db_name          = var.database_name
        db_endpoint      = aws_network_interface.private-db-internal-interface.private_ip
    }
}

resource "aws_instance" "app-server" {
    ami = "ami-00e912d13fbb4f225"
    instance_type = "t2.micro"
    key_name = "mid-project-key"

    user_data = data.template_file.app-server-init.rendered

    network_interface {
        network_interface_id = aws_network_interface.public-app-interface.id
        device_index = 0
    }

    network_interface {
        network_interface_id = aws_network_interface.private-app-internal-interface.id
        device_index = 1
    }
    tags = {
        Name = "mid-project-app-server"
    }
}

output "db-internal-ip" {
    value = aws_network_interface.private-db-internal-interface.private_ip
}

output "db-to-nat-ip" {
    value = aws_instance.db-server.private_ip
}

output "app-internal-ip" {
    value = aws_network_interface.private-app-internal-interface.private_ip
}

output "app-public-ip" {
    value = aws_instance.app-server.public_ip
}
