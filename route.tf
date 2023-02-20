resource "aws_route_table" "mytest_rt" {
  vpc_id = aws_vpc.mytest_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mytest_igw.id
  }

  tags = {
    Name = "mytest-rt"
  }
}

# Associate subnets with route table
resource "aws_route_table_association" "mytest_rt_assoc_1" {
  subnet_id      = aws_subnet.mytest_subnet_1.id
  route_table_id = aws_route_table.mytest_rt.id
}

resource "aws_route_table_association" "mytest_rt_assoc_2" {
  subnet_id      = aws_subnet.mytest_subnet_2.id
  route_table_id = aws_route_table.mytest_rt.id
}