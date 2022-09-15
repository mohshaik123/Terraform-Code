output "apache-ip" {
  value = aws_instance.apache.public_ip
}

output "apache-dns" {
  value = aws_instance.apache.public_dns
}

output "apache-arn" {
  value = aws_instance.apache.arn
}

output "cicd-ip" {
  value = aws_instance.cicd.public_ip
}

output "cicd-dns" {
  value = aws_instance.cicd.public_dns
}

output "cicd-arn" {
  value = aws_instance.cicd.arn
}