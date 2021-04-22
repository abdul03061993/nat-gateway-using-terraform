resource "aws_subnet" "test2_subnet" {
    vpc_id = aws_vpc.test.id
    cidr_block = "192.168.2.0/24"
    availability_zone = "${data.aws_availability_zone.zone.id}"
    tags = {
        Name = "privatesubnet"
    }
}
 
resource "aws_nat_gateway" "test_nat_gateway" {
    allocation_id = var.eip_allocation
    subnet_id = aws_subnet.test1_subnet.id
    tags = {
        Name = "Natgateway"
    }
}
 
resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.test.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.test_nat_gateway.id
    }
    tags = {
        Name = "Private_route"
    }
}
resource "aws_route_table_association" "private_route_table" {
     subnet_id =  aws_subnet.test2_subnet.id
     route_table_id = aws_route_table.private_route_table.id
}

