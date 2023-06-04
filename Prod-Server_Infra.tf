terraform{
         required_providers {
                 aws = {
                         source = "hashicorp/aws"
                         version = "~> 4.0"
                 }
         }
}

# Configure Providers

provider "aws" {
  region  = "us-east-1"
  access_key = "AKIATVOIMA34DCNGVROL"
  secret_key = "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"

}

# Deploy Ec2 instances

resource "aws_instance" "prod-server"{
        ami = "ami-053b0d53c279acc90"
        key_name = "AWS_Key"
        instance_type = "t2.micro"
        tags = {
        Name = "Prod-Server"
        }

resource "null_resource" "localinventorynull02" {
         triggers = {
                 mytest = timestamp()
         }
        
         provisioner "local-exec" {
             command = "echo ${aws_instance.prod-server.tags.Name} ansible_host=${aws_instance.prod-server.public_ip} ansible_user=ec2-user>> inventory"

           }

 
         depends_on = [

                          null_resource.localinventorynull01
                          ]
          }
resource "null_resource" "mydynamicinventory" {

        triggers = {
                mytest = timestamp()
        }

        provisioner "local-exec" {
            command = "scp inventory ubuntu@54.89.174.78:/tmp/"
  
          }
        depends_on = [
                       
                        null_resource.localinventorynull02 , null_resource.localinventorynull01
                        ]
          }
resource  "null_resource"  "ssh3" {

	triggers = {
		mytest = timestamp()
	}

	connection {
	    type     = "ssh"
	    user     = "ubuntu"
	    private_key = "/home/ubuntu/AWS_Key.pem"
	    host     = var.ansible
	  }

	provisioner "remote-exec" {
	    inline = [
              "sudo chmod 777 /tmp/inventory",
              "sudo mv /tmp/inventory /root/ansible/inventory",
	    ]
	  }
                        
        