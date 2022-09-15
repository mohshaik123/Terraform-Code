resource "aws_security_group" "cicd" {
  name        = "allow_cicd"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-02b8d66a7707ed146"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "cicd"
  }
}

resource "aws_instance" "cicd" {
  ami                    = "ami-06489866022e12a14"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-08ef2aa21129b2288"
  vpc_security_group_ids = [aws_security_group.cicd.id]
  iam_instance_profile   = aws_iam_instance_profile.artifactory.name
  #   key_name = "testing-key"
  key_name  = aws_key_pair.demo.id
  user_data = <<-EOF
              #!/bin/bash
              wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade
amazon-linux-extras install java-openjdk11
yum install jenkins
systemctl start jenkins
systemctl enable jenkins
              EOF

  tags = {
    Name = "CICD"
  }
}