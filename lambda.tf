resource "aws_lambda_function" "test_asg_final" {
  function_name = "lambda-asg-out"
  role = aws_iam_role.role_lambda_base.arn
  description = "disable asg and shutdown instance"

  runtime = "python3.9"
  handler = "lambda-asg-out.lambda_handler"


  s3_bucket = aws_s3_bucket.pyk_test2.id
  s3_key = aws_s3_bucket_object.lambda-function-zip.key

  

}


resource "aws_lambda_function" "test_asg_on" {
  function_name = "lambda-asg-on"
  role = aws_iam_role.role_lambda_base.arn
  description = "enable asg processes"

  runtime = "python3.9"
  handler = "lambda-asg-on.lambda_handler"


  s3_bucket = aws_s3_bucket.pyk_test2.id
  s3_key = aws_s3_bucket_object.lambda-function-asg-on.key

  

}

resource "aws_lambda_function" "test_ec2_on" {
  function_name = "lambda-ec2-on"
  role = aws_iam_role.role_lambda_base.arn
  description = "start ec2 instances"

  runtime = "python3.9"
  handler = "lambda-ec2-on.lambda_handler"


  s3_bucket = aws_s3_bucket.pyk_test2.id
  s3_key = aws_s3_bucket_object.lambda-function-ec2-on.key

  

}