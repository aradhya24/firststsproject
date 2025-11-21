output "public_ip" {
  value = aws_eip_association.attach_eip.public_ip
}
