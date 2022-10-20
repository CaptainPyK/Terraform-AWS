resource "aws_security_group" "DEV-RDP-allowed" {
    name        = "rdp"
    description = local.terraform_managed
    vpc_id = "${aws_vpc.pyk-dev-vpc.id}"
    
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 3389
        to_port = 3389
        protocol = "tcp"

        cidr_blocks = ["0.0.0.0/0"]
    }

    tags =  {
        Name = "RDP-allowed"
    }
}

resource "aws_security_group" "DEV-ICMP-allowed" {
  name        = "icmp"
  description = local.terraform_managed
  vpc_id = "${aws_vpc.pyk-dev-vpc.id}"

  ingress {
    description     = "ICMP from infra"
    from_port       = 8
    to_port         = 0
    protocol        = "icmp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "ICMP-allowed"
  }
}
