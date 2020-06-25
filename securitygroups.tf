#------------------------------------------------------------
# Instance security group
#------------------------------------------------------------

# security group for SSH connection
resource "aws_security_group" "open_access" {
    vpc_id = aws_vpc.default.id
    name = "open_access"
    description = "open_access"

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow-ssh"
    }
  
}