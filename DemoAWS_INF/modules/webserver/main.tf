
resource "aws_security_group" "myapp-sg" {
  name   = "myapp-sg"
  vpc_id = var.vpc_id

  # incomming rules
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # cidr_blocks = [var.my_ip]
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # outgoing rules
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
  tags = {
    Name : "${var.env_prefix}-sg"
  }
}

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"
    # values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
    values = [var.image_name]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}


resource "aws_key_pair" "ssh-key" {
  key_name   = "server-key-pair"
  public_key = file(var.public_key_location)

}
resource "aws_instance" "myapp-server" {
  # ami = "ami-02c21308fed24a8ab"
  ami           = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type

  # subnet_id              = aws_subnet.dev-subnet-1.id
  /*
    subnet id come form module
    module.myapp-subnet.subnet.id
  */
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  availability_zone      = var.avail_zone

  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name

  user_data = file("entry-script.sh")
  tags = {
    Name : "${var.env_prefix}-server"
  }
}
