# Security Group for SSH and HTTP
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Allow SSH and HTTP inbound traffic"

  # SSH access
  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # Open to all (restrict in production!)
  }

  # HTTP access
  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terraform-EC2-SG"
  }
}

# EC2 Instance with Security Group attached
resource "aws_instance" "myinsta" {
  ami           = "ami-0f8a61b66d1accaee"
  instance_type = "t3.micro"
  # Uncomment and set this to an existing key pair name in your AWS account if you need SSH access.
  key_name      = "Newkey"
  subnet_id     = "subnet-06c88807658f0790d"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Hello Mrunali"
  }
}
