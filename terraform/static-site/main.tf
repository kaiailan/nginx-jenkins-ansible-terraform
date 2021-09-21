terraform {
  required_version = "~> 1.0.4"
}

provider "aws" {
    region = var.region
    profile = var.profile
}

resource "aws_instance" "site" {
    ami = "ami-0567f647e75c7bc05"
    instance_type = "t2.micro"
    key_name = "devops_01"
    vpc_security_group_ids = ["sg-02449e41","sg-0fe5f6e98a0225201"]
        tags = {
            Name = var.name
            group = var.group
        }
}