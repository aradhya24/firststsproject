# ---------------------------------
# Security Group for SSH + Tomcat
# ---------------------------------
resource "aws_security_group" "allow_ssh_tomcat" {
  name        = "allow_ssh_tomcat"
  description = "Allow SSH and Tomcat"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Tomcat"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ---------------------------------
# EC2 Instance (with Tomcat9 install)
# ---------------------------------
resource "aws_instance" "my_ec2" {
  ami                    = "ami-0a716d3f3b16d290c"
  instance_type          = "t3.micro"
  key_name               = "aradhya"
  availability_zone      = "eu-north-1a"

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_ssh_tomcat.id]

  user_data = <<-EOF
#!/bin/bash
apt update -y
apt install -y openjdk-17-jdk
apt install -y tomcat9 tomcat9-admin tomcat9-common
mkdir -p /var/lib/tomcat9/webapps
chown -R tomcat:tomcat /var/lib/tomcat9/webapps
systemctl enable tomcat9
systemctl start tomcat9
EOF

  tags = {
    Name = "firststsproject"
  }
}
