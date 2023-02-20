# Define Ansible inventory file
resource "local_file" "ansible_inventory" {
  content = <<-EOF
            [web]
            ${aws_lb.mytest_lb.dns_name}
            EOF
  filename = "ansible_inventory"
}

# Define Ansible playbook
resource "local_file" "ansible_playbook" {
  content = <<-EOF
            ---
            - hosts: web
              become: yes
              tasks:
		- name: Test HTTP redirect to HTTPS
		  uri:
		  	url: http://{{ hostvars['web'].ansible_host }}/
			return_content: yes
		  register: http_response
		  until: http_response.status == 301
		  retries: 5
		  delay: 5

		- name: Test SSL connection
		  uri:
			url: https://{{ hostvars['web'].ansible_host }}/
			return_content: yes
		  register: https_response
		  until: https_response.status == 200
		  retries: 5
		  delay: 5	
            EOF
  filename = "ansible_playbook.yml"
}

# Apply Ansible playbook to EC2 instance
provisioner "local-exec" {
  command = "ansible-playbook -i ansible_inventory ansible_playbook.yml"
  working_dir = "${path.root}/"
}



#Validate the configuration of the EC2 instances using Ansible
resource "null_resource" "mytest_ansible" {
connection {
type = "ssh"
user = var.ansible_user
private_key = file(var.ansible_private_key)
host = aws_lb.mytest_lb.dns_name
}

provisioner "local-exec" {
command = "ansible-playbook -i '${aws_lb.mytest_lb.dns_name},' -u ${var.ansible_user} --private-key ${var.ansible_private_key} --extra-vars 'target_group_arn=${aws_lb_target_group.mytest_tg.arn}' playbook.yml"
}

depends_on = [aws_autoscaling_group.mytest_asg]
}