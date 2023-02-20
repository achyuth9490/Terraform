# Create an Internet Gateway and route table
resource "aws_internet_gateway" "mytest_igw" {
  vpc_id = aws_vpc.mytest_vpc.id

  tags = {
    Name = "mytest-igw"
  }
}
