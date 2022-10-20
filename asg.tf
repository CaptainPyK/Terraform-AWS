#ASG For API

resource "aws_launch_template" "launch_pyk" {


  name  = "asg_pyk"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 30
    }
  }

  #ebs_optimized = true
  image_id = "ami-0af2985aa85c2ca32"
  instance_initiated_shutdown_behavior = "stop"
  instance_type = "t2.micro"
  key_name = "key_pair_ec2"

  vpc_security_group_ids = [
      aws_security_group.DEV-RDP-allowed.id,
      aws_security_group.DEV-ICMP-allowed.id
  ]

  update_default_version = true




}


resource "aws_autoscaling_group" "asg_pyk0" {


  name = "asg_pyk0"

  desired_capacity   = 1
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.launch_pyk.id
    version = "$Latest"
  }

  vpc_zone_identifier  = [aws_subnet.dev-subnet-private-1.id]
  termination_policies = [ "NewestInstance" ]

  #target_group_arns = [ aws_lb_target_group.iresa_preprod_front_api_http.arn ]

  lifecycle {
    prevent_destroy = false
    ignore_changes = [suspended_processes]
  }

     tag {
    key                 = "Sites"
    value               = "3,6,3,9"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "asg_pyk1" {


  name = "asg_pyk1"

  desired_capacity   = 1
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.launch_pyk.id
    version = "$Latest"
  }

  vpc_zone_identifier  = [aws_subnet.dev-subnet-private-1.id]
  termination_policies = [ "NewestInstance" ]

  #target_group_arns = [ aws_lb_target_group.iresa_preprod_front_api_http.arn ]

  lifecycle {
    prevent_destroy = false
    ignore_changes = [suspended_processes]
  }
   tag {
    key                 = "Sites"
    value               = "5,8,9"
    propagate_at_launch = true
  }

 }