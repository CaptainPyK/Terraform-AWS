resource "aws_instance" "PYK-TEMP-01" {
  ami                    = "ami-0af2985aa85c2ca32"
  instance_type          = "t2.micro"
  subnet_id   = aws_subnet.dev-subnet-public-1.id
  key_name= aws_key_pair.key_pair_ec2.key_name
  iam_instance_profile = "testec2"
  vpc_security_group_ids = [
      aws_security_group.DEV-RDP-allowed.id,
      aws_security_group.DEV-ICMP-allowed.id,
  ]

  root_block_device {
    volume_size = 30
  }

  tags = {
    Name      = "PYK-TEMP-01"
    Terraform = local.terraform_managed
  
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes = [ami]
  }
}