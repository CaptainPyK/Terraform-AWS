resource "aws_vpc" "pyk-dev-vpc" {
    cidr_block = "10.1.0.0/16"
    enable_dns_support = true #gives you an internal domain name
    enable_dns_hostnames = true #gives you an internal host name
    enable_classiclink = false
    
    
    tags = {
        Name = "pyk-dev-vpc"
        Terraform = local.terraform_managed
    }
}

resource "aws_subnet" "dev-subnet-public-1" {
    vpc_id = "${aws_vpc.pyk-dev-vpc.id}"
    cidr_block = "10.1.1.0/24"
    map_public_ip_on_launch = true //it makes this a public subnet
    availability_zone = "eu-west-3a"
    tags = {
        Name = "dev-subnet-public-1"
    }
}

resource "aws_subnet" "dev-subnet-public-2" {
    vpc_id = "${aws_vpc.pyk-dev-vpc.id}"
    cidr_block = "10.1.2.0/24"
    map_public_ip_on_launch = true //it makes this a public subnet
    availability_zone = "eu-west-3b"
    tags = {
        Name = "dev-subnet-public-2"
    }
}

resource "aws_subnet" "dev-subnet-private-1" {
    vpc_id = "${aws_vpc.pyk-dev-vpc.id}"
    cidr_block = "10.1.101.0/24"
    map_public_ip_on_launch = false //it makes this a public subnet
    availability_zone = "eu-west-3a"
    tags = {
        Name = "dev-subnet-private-1"
    }
}
resource "aws_subnet" "dev-subnet-private-2" {
    vpc_id = "${aws_vpc.pyk-dev-vpc.id}"
    cidr_block = "10.1.102.0/24"
    map_public_ip_on_launch = false //it makes this a public subnet
    availability_zone = "eu-west-3b"
    tags = {
        Name = "dev-subnet-private-2"
    }
}