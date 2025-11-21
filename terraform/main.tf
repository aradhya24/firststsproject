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

# Required for tomcat package
apt install -y software-properties-common
add-apt-repository universe -y
apt update -y

# Install Java
apt install -y openjdk-17-jdk

# Install Tomcat9
apt install -y tomcat9 tomcat9-admin tomcat9-common

# Create Tomcat webapps folder
mkdir -p /var/lib/tomcat9/webapps
chown -R tomcat:tomcat /var/lib/tomcat9/webapps

systemctl enable tomcat9
systemctl start tomcat9
EOF

  tags = {
    Name = "firststsproject"
  }
}
