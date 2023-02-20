Create a listener for the load balancer
resource "aws_lb_listener" "mytest_listener" {
load_balancer_arn = aws_lb.mytest_lb.arn
port = 80
protocol = "HTTP"

default_action {
type = "redirect"
redirect {
port = "443"
protocol = "HTTPS"
status_code = "HTTP_301"
}
}

depends_on = [aws_lb_target_group.mytest_tg]
}

Create a listener for HTTPS traffic
resource "aws_lb_listener" "mytest_listener_https" {
load_balancer_arn = aws_lb.mytest_lb.arn
port = 443
protocol = "HTTPS"

default_action {
target_group_arn = aws_lb_target_group.mytest_tg.arn
type = "forward"
}

ssl_policy = "ELBSecurityPolicy-TLS-1-2-2017-01"
certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/abcdef12-3456-7890-abcd-1234567890ab"

depends_on = [aws_lb_target_group.mytest_tg]
}