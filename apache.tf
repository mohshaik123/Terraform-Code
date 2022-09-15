resource "aws_security_group" "apache" {
  name        = "allow_client"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-02b8d66a7707ed146"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "apache"
  }
}

resource "aws_instance" "apache" {
  ami           = "ami-06489866022e12a14"
  instance_type = "t2.micro"
  subnet_id = "subnet-08ef2aa21129b2288"
  vpc_security_group_ids =[aws_security_group.apache.id]
  key_name = aws_key_pair.demo.id
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install httpd -y
              systemctl start httpd
              systemctl enable httpd
              EOF

  tags = {
    Name = "Apache"
  }

  # lifecycle {
  #   create_before_destroy = true
  # }
}