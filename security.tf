# resource "aws_security_group" "ssh-access" {
#     ingress {
#         description = "SSH"
#         from_port   = 22
#         to_port     = 22
#         protocol    = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     vpc_id = aws_vpc.mid-project.id
#     tags = {
#         Name = "ssh-access"
#     }
# }

# resource "aws_security_group" "http-access" {

#     ingress {
#         description = "HTTP"
#         from_port   = 80
#         to_port     = 80
#         protocol    = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     vpc_id = aws_vpc.mid-project.id
#     tags = {
#         Name = "ssh-access"
#     }
# }

# resource "aws_security_group" "mysql-access" {

#     ingress {
#         description = "MYSQL"
#         from_port   = 3306
#         to_port     = 3306
#         protocol    = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     vpc_id = aws_vpc.mid-project.id
#     tags = {
#         Name = "mysql-access"
#     }
# }

# resource "aws_security_group" "outbound-all-access" {
#     egress {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     vpc_id = aws_vpc.mid-project.id
#     tags = {
#         Name = "outbound-all-access"
#     }
# }

resource "aws_security_group" "http-full-access" {
    ingress {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = aws_vpc.mid-project.id
    tags = {
        Name = "ssh-access"
    }
}

resource "aws_security_group" "ssh-full-access" {
    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = aws_vpc.mid-project.id
    tags = {
        Name = "ssh-full-access"
    }
}

resource "aws_security_group" "ssh-internal-access" {
    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.private_internal_subnet]
    }

    vpc_id = aws_vpc.mid-project.id
    tags = {
        Name = "ssh-internal-access"
    }
}

resource "aws_security_group" "mysql-internal-access" {
    ingress {
        description = "MYSQL"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = [var.private_internal_subnet]
    }

    vpc_id = aws_vpc.mid-project.id
    tags = {
        Name = "mysql-internal-access"
    }
}

resource "aws_security_group" "outbound-full-access" {
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    vpc_id = aws_vpc.mid-project.id
    tags = {
        Name = "outbound-full-access"
    }
}