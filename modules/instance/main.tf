/* AMI */
data "aws_ami" "amazon-linux-2" {
 most_recent = true

 filter {
  name   = "owner-alias"
  values = ["amazon"]
 }

 filter {
  name   = "name"
  values = ["amzn2-ami-hvm*"]
 }
}
/* Bastion security group */
resource "aws_security_group" "allow-ssh" {
 vpc_id       = module.networking.vpc_id
 name         = "allow-ssh"
 description  = "security group that allows ssh and all egress traffic"
 egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }

 ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
  Name = "allow-ssh"
  Environment = var.environment
 }
}
/* Instance security group */
resource "aws_security_group" "allow-tpc-ssh" {
 vpc_id       = module.networking.vpc_id
 name         = "TCP-SSH"
 description  = "security group that allows tcp + ssh and all egress traffic"
 egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = [var.public_subnets_cidr]
 }
 tags = {
  Name = "allow-ssh"
  Environment = var.environment
 }
}
/* Bastion instance */
resource "aws_instance" "bastion_instance" {
 ami                    = data.aws_ami.amazon-linux-2.id
 instance_type          = var.instance_type

 subnet_id = element(module.networking.public_subnets_ids, 1)

 vpc_security_group_ids = [aws_security_group.allow-ssh.id]

 key_name = aws_key_pair.mykeypair.key_name

 tags = {
  Name = "bastion-instance"
  Environment = var.environment
 }
}
/* Instance */
resource "aws_instance" "private_instance" {
 ami                    = data.aws_ami.amazon-linux-2.id
 instance_type          = var.instance_type

 subnet_id              = element(module.networking.private_subnets_ids, 1)

 vpc_security_group_ids = [aws_security_group.allow-tcp-ssh.id]

 key_name               = aws_key_pair.keypair.key_name
 
 tags = {
  Name = "${var.environment}-${var.app_name}-instance"
  Environment = var.environment
 }
}

resource "aws_key_pair" "keypair" {
 key_name     = "${var.environment}-${var.app_name}-key-pair"
 public_key   = file(var.key_path)
}
