#Configure security group for the EC2 instances
resource "aws_security_group" "mytest_sg" {
name = "mytest_sg"
vpc_id = aws_vpc.mytest_vpc.id

ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 443
to_port = 443
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}

lifecycle {
create_before_destroy = true
}
}