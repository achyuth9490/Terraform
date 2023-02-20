#Create an SSL certificate for HTTPS traffic
resource "aws_acm_certificate" "mytest_cert" {
domain_name = "mytest.com"
validation_method = "DNS"

lifecycle {
create_before_destroy = true
}
}

#Create a DNS validation record for the SSL certificate
resource "aws_route53_record" "mytest_cert_validation" {
name = aws_acm_certificate.mytest_cert.domain_validation_options.0.resource_record_name
type = aws_acm
}

Create a DNS validation record for the SSL certificate
resource "aws_route53_record" "mytest_cert_validation" {
name = aws_acm_certificate.mytest_cert.domain_validation_options.0.resource_record_name
type = aws_acm_certificate.mytest_cert.domain_validation_options.0.resource_record_type
zone_id = var.hosted_zone_id
ttl = 300
records = [aws_acm_certificate.mytest_cert.domain_validation_options.0.resource_record_value]

depends_on = [aws_acm_certificate.mytest_cert]
}

#Wait for the SSL certificate to be issued
resource "null_resource" "wait_for_cert" {
provisioner "local-exec" {
command = "while [[ "$(aws acm describe-certificate --certificate-arn ${aws_acm_certificate.mytest_cert.arn} --query Certificate.Status --output text)" != "ISSUED" ]]; do sleep 10; done"
}

depends_on = [aws_route53_record.mytest_cert_validation]
}

#Attach the SSL certificate to the load balancer
resource "aws_lb_listener_certificate" "mytest_cert" {
listener_arn = aws_lb_listener.mytest_listener_https.arn
certificate_arn = aws_acm_certificate.mytest_cert.arn

depends_on = [null_resource.wait_for_cert]
}