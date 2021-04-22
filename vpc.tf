resource "aws_vpc" "test" {
    cidr_block = "192.168.0.0/16"
    tags = { 
     Name = "test_vpc"
     }
}

