output "lb_service1_dns" {
  value = aws_lb.publiclb.dns_name
}
output "lb_service2_dns" {
  value = aws_lb.privatelb.dns_name
}