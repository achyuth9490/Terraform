# Create VPC and subnets
resource "aws_vpc" "mytest_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "mytest-vpc"
  }
}

