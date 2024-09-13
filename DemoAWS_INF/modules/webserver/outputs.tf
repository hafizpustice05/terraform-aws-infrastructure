/*
    this output return to main which call this module
*/
output "ec2_instance" {
  value = aws_instance.myapp-server
}
