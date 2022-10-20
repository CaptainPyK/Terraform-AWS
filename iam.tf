resource "aws_iam_role" "role_lambda_base" {

  name = "role-lambda-base"
  assume_role_policy = jsonencode(
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
        ]
    }   
  )
}


resource "aws_iam_role_policy" "lambda_execution" {

  name = "lambda_execution"
  role = aws_iam_role.role_lambda_base.id
  policy = jsonencode(
      {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:eu-west-3:896908782021:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:eu-west-3:896908782021:log-group:/aws/lambda/testasg:*"
            ]
        },
                {
            "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        },
                {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:*",
            "Resource": "*"
        },
                {
            "Effect": "Allow",
            "Action": "autoscaling:*",
            "Resource": "*"
        },
                {
            "Effect": "Allow",
            "Action": "cloudwatch:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "ssm:SendCommand",
            "Resource": "*"
        },
    ]
}
  )
}


#resource "aws_iam_role" "packer_role" {
#
#  name = "packer-role"
#  assume_role_policy = jsonencode(
#    {
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Effect": "Allow",
#            "Principal": {
#                "Service": "ec2.amazonaws.com"
#            },
#            "Action": "sts:AssumeRole"
#        }
#        ]
#    }   
#  )
#}

resource "aws_iam_policy" "packer_policy" {

  name = "packer-policy"
# role = aws_iam_role.packer_role.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
        "ec2:AttachVolume",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CopyImage",
        "ec2:CreateImage",
        "ec2:CreateKeypair",
        "ec2:CreateSecurityGroup",
        "ec2:CreateSnapshot",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteKeyPair",
        "ec2:DeleteSecurityGroup",
        "ec2:DeleteSnapshot",
        "ec2:DeleteVolume",
        "ec2:DeregisterImage",
        "ec2:DescribeImageAttribute",
        "ec2:DescribeImages",
        "ec2:DescribeInstances",
        "ec2:DescribeInstanceStatus",
        "ec2:DescribeRegions",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSnapshots",
        "ec2:DescribeSubnets",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes",
        "ec2:DetachVolume",
        "ec2:GetPasswordData",
        "ec2:ModifyImageAttribute",
        "ec2:ModifyInstanceAttribute",
        "ec2:ModifySnapshotAttribute",
        "ec2:RegisterImage",
        "ec2:RunInstances",
        "ec2:StopInstances",
        "ec2:TerminateInstances",
        "ec2:DescribeVpcs"
      ],
          "Resource" : "*"
        }
      ]
    }
  )
}


resource "aws_iam_user" "packer_user" {

  name = "packer-user"

  tags = {
    Terraform = local.terraform_managed
  }
}

resource "aws_iam_access_key" "packer_user" {
  
  user    = aws_iam_user.packer_user.name
}

resource "aws_iam_user_policy_attachment" "packer" {

  user       = aws_iam_user.packer_user.name
  policy_arn = aws_iam_policy.packer_policy.arn
}

