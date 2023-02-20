resource "aws_subnet" "mytest_subnet_1" {
  vpc_id     = aws_vpc.mytest_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "mytest-subnet-1"
  }
}

resource "aws_subnet" "mytest_subnet_2" {
  vpc_id     = aws_vpc.mytest_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "mytest-subnet-2"
  }
}
