#------------------------------------------------------------
# VPC definition
#------------------------------------------------------------
resource "aws_vpc" "default" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "default"
    }
}

#------------------------------------------------------------
# Data sources to get subnet data
#------------------------------------------------------------
# data "aws_subnet_ids" "all" {
#   vpc_id = aws_vpc.default.id
# }

#------------------------------------------------------------
# Database subnet group
#------------------------------------------------------------
resource "aws_subnet" "main-public-1" {
    vpc_id = aws_vpc.default.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-west-2a"

    tags = {
        Name = "main-public-1"
    }
}

resource "aws_subnet" "main-public-2" {
    vpc_id = aws_vpc.default.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-west-2b"

    tags = {
        Name = "main-public-2"
    }
}



# resource "aws_redshift_subnet_group" "redshift-subnet" {
#     name = "redshift-subnet"
#     description = "Amazon Redshift subnet group"
#     # this subnet group specifies that the Amazon Redshift will be put in a public subnet
#     subnet_ids = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
# }

# Internet Gateway
resource "aws_internet_gateway" "main-gateway" {
    vpc_id = aws_vpc.default.id

    tags = {
        Name = "main-gateway"
    }
}

# route tables
resource "aws_route_table" "main-public" {
    vpc_id = aws_vpc.default.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-gateway.id
    }

    tags = {
        Name = "main-public-1"
    }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
    subnet_id = aws_subnet.main-public-1.id
    route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "main-public-2-a" {
    subnet_id = aws_subnet.main-public-2.id
    route_table_id = aws_route_table.main-public.id
}
