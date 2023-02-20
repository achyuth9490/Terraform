#Create a launch configuration
resource "aws_launch_configuration" "mytest_lc" {
name_prefix = "mytest-lc-"
image_id = var.ami_id
instance_type = var.instance_type
security_groups = [aws_security_group.mytest_sg.id]
key_name = var.key_name

user_data = <<-EOF
#!/bin/bash
sudo yum -y update
sudo yum -y install httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo '<html><head><title>Hello World</title></head><body><h1>Hello World!</h1></body></html>' > /var/www/html/index.html
EOF

lifecycle {
create_before_destroy = true
}
}

#Create an auto-scaling group
resource "aws_autoscaling_group" "mytest_asg" {
name = "mytest-asg"
vpc_zone_identifier = [aws_subnet.mytest_subnet_1.id, aws_subnet.mytest_subnet_2.id]
launch_configuration = aws_launch_configuration.mytest_lc.id
desired_capacity = var.desired_capacity

target_group_arns = [aws_lb_target_group.mytest_tg.arn]

tags = {
Name = "mytest-asg"
}

lifecycle {
create_before_destroy = true
}
}
