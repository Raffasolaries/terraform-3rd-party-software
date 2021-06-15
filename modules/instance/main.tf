/* AMI */
// data "aws_ami" "amazon-linux-2" {
//  most_recent = true
//  owners  = ["self"]

//  filter {
//   name   = "owner-alias"
//   values = ["amazon"]
//  }

//  filter {
//   name   = "name"
//   values = ["amzn2-ami-hvm*"]
//  }
// }
/* Bastion security group */
resource "aws_security_group" "allow-ssh" {
 vpc_id       = var.vpc_id
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
resource "aws_security_group" "allow-tcp-ssh" {
 vpc_id       = var.vpc_id
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
  cidr_blocks = var.public_subnets_cidr
 }
 tags = {
  Name = "allow-ssh"
  Environment = var.environment
 }
}
/* Bastion instance */
resource "aws_instance" "bastion_instance" {
 ami                    = var.ami_id
 instance_type          = "t3.micro"

 subnet_id = var.subnet_id

 vpc_security_group_ids = [aws_security_group.allow-ssh.id]

 key_name = aws_key_pair.keypair.key_name

 tags = {
  Name = "bastion-instance"
  Environment = var.environment
 }
}
/* Instance */
resource "aws_instance" "private_instance" {
 ami                    = var.ami_id
 instance_type          = var.instance_type

 subnet_id              = var.subnet_id

 vpc_security_group_ids = [aws_security_group.allow-tcp-ssh.id]

 key_name               = aws_key_pair.keypair.key_name

 root_block_device {
  delete_on_termination = false
  encrypted = true
  volume_type = var.volume_type
  volume_size = var.volume_size

  tags = {
   Name = "${var.environment}-${var.app_name}-ebs"
   Environment = var.environment
  }
 }
 
 tags = {
  Name = "${var.environment}-${var.app_name}-instance"
  Environment = var.environment
 }
}

resource "aws_key_pair" "keypair" {
 key_name     = "${var.environment}-${var.app_name}-key-pair"
 public_key   = file(var.key_path)
 tags = {
  Name = "${var.environment}-${var.app_name}-key-pair"
  Environment = var.environment
 }
}