output "public_ip" {
  value = module.webserver.ec2_instance.public_ip

}
