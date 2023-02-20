In this code, I have created:
1. AWS Load Balancer
2. Target group for the load balancer
3. An auto-scaling group
4. A launch configuration for the EC2 instances. 

The Load Balancer listens on ports 80 and 443, and any HTTP requests are automatically redirected to HTTPS. 

We have also created an SSL certificate for HTTPS traffic and attached it to the load balancer. 

The security group for the EC2 instances has been configured to allow traffic on ports 80 and 443. 

Finally, we have used a null resource to run an Ansible playbook to validate the configuration of the EC2 instances.



Workflow:
Each service is grouped under respective file. 
The solution generates scalable EC2 using auto scaling. The load balancer will accept traffic on both port 80 and 443, redirect 80 to 443 and forward traffic on 443 to the server. 
