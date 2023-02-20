# Create a load balancer
resource "aws_lb" "mytest_lb" {
  name               = "mytest-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.mytest_subnet_1.id, aws_subnet.mytest_subnet_2.id]

  security_groups = [aws_security_group.mytest_sg.id]
}

#Create a target group
resource "aws_lb_target_group" "mytest_tg" {
name = "mytest-tg"
port = 80
protocol = "HTTP"

vpc_id = aws_vpc.mytest_vpc.id

health_check {
interval = 30
path = "/"
protocol = "HTTP"
timeout = 10
healthy_threshold = 3
unhealthy_threshold = 3
}

tags = {
Name = "mytest-tg"
}
}