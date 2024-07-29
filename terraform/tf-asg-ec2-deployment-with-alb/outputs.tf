output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_a_id" {
  description = "The ID of subnet A"
  value       = aws_subnet.subnet_a.id
}

output "subnet_b_id" {
  description = "The ID of subnet B"
  value       = aws_subnet.subnet_b.id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.main.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "autoscaling_group_id" {
  description = "The ID of the Auto Scaling Group"
  value       = aws_autoscaling_group.main.id
}

output "load_balancer_dns" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}
