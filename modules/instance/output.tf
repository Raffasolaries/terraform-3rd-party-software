output "instance_id" {
 value = aws_instance.private_instance.id
}

output "instance_security_group_id" {
 value = aws_security_group.allow-tcp-ssh.id
}