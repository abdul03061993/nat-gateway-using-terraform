resource "aws_subnet" "test1_subnet" {
    vpc_id = aws_vpc.test.id
     cidr_block =  "192.168.1.0/24"
     availability_zone = "${data.aws_availability_zone.zone.id}"
     map_public_ip_on_launch = true 
     tags = { 
       Name = "publicsubnet"
     }
}
 
resource "aws_internet_gateway" "test_internet_gateway" {
    vpc_id = aws_vpc.test.id
    tags = {
       Name = "Test_gateway"
    }
}
 
resource "aws_route_table" "public_route_table"{ 
    vpc_id = aws_vpc.test.id
    
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_internet_gateway.id
}
tags = {
    Name = "public_route"
  }
}
resource "aws_route_table_association" "association" {
    subnet_id = aws_subnet.test1_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}

