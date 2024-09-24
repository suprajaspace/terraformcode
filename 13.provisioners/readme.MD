### provisioners

for reference: https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax

After instance created, if any changes needed in instances can use provisioners.

provisioners are used to take some actions locally or remotely..

local --> where terraform executed is local...my laptop

remote --> inside the servers you created..inside the servers of backend, frontend, mysql. etc.

1. local-exec
2. remote-exec

remote-exec --> execute commands inside remote server

using this provisioners integrating terraform and configuration management(ansible).

```
provisioner "local-exec" {
    # command = "echo ${aws_instance.terraform.private_ip} > public_ip.txt"
    command = "echo ${self.private_ip} > public_ip.txt"
  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }
  # provisioners will excute at the time of execution
  provisioner "remote-exec" {
    inline = [
      "sudo dnf install ansible -y",
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx",

    ]
  }
  provisioner "remote-exec" {
    when = destroy
    inline = [
      "sudo systemctl stop nginx",
    ]
  }

  ```
here "self" is used to reference to current resource.

self.private_ip --> private Ip of current resource.

`command = "echo ${self.private_ip} > public_ip.txt" `
the private IP address of an AWS instance is saved to a local 

```
connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }
```

AWS instance is created, the remote-exec provisioner connects to it via SSH and runs commands to install ansible, nginx, and start nginx.

for destroy the instance first stop nginx then destroy instances.

```
  provisioner "remote-exec" {
    inline = [
      "sudo dnf install ansible -y",
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx",

    ]
  }
  provisioner "remote-exec" {
    when = destroy
    inline = [
      "sudo systemctl stop nginx",
    ]
  }

  ```













  










