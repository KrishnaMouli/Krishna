resource "aws_instance" "web" {
  ami           = "ami-066333d9c572b0680"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-0b93cbff950d2f6c0"]
  key_name = "apple"
  
  connection {
    host        = "${self.public_ip}"
    user        = "ec2-user"
    type        = "ssh"
    private_key = "${file("/root/apple")}"
  }
   

   provisioner "file" {
     source      = "./apple"
     destination = "/home/ec2-user/apple"

    connection {
      host        = "${self.public_ip}"
      user        = "ec2-user"
      type        = "ssh"
      private_key = "${file("/root/apple")}"
     }
   }

   provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ec2-user/apple",
      "sudo amazon-linux-extras install java-openjdk11 -y",
      "sudo yum install java-1.8.0-openjdk -y",
    ]
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} ansible_ssh_user=ec2-user ansible_ssh_private_key_file=/root/apple > /etc/ansible/hosts"
  }
  

  tags = {
    Name = "HelloWorld"
  }
}
