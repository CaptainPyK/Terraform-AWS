resource "aws_s3_bucket" "pyk_test2" {


  bucket = "pyk-test2"

  tags = {
    Name        = "pyk-test"
  }
}

resource "aws_s3_bucket" "pyk_test3" {


  bucket = "pyk-test3"

  tags = {
    Name        = "pyk-test1"
  }
}

resource "aws_s3_bucket_public_access_block" "pyk_test2" {


  bucket = aws_s3_bucket.pyk_test2.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_object" "lambda-function" {


  key        = "scripts/lambda-asg-out.py"
  bucket     = aws_s3_bucket.pyk_test2.id
  source     = "scripts/lambda-asg-out.py"
}

resource "aws_s3_bucket_object" "lambda-function-zip" {


  key        = "scripts/lambda-asg-out.zip"
  bucket     = aws_s3_bucket.pyk_test2.id
  source     = "scripts/lambda-asg-out.zip"
}


resource "aws_s3_bucket_object" "lambda-function-ec2-on" {


  key        = "scripts/lambda-ec2-on.zip"
  bucket     = aws_s3_bucket.pyk_test2.id
  source     = "scripts/lambda-ec2-on.zip"
}

resource "aws_s3_bucket_object" "lambda-function-asg-on" {


  key        = "scripts/lambda-asg-on.zip"
  bucket     = aws_s3_bucket.pyk_test2.id
  source     = "scripts/lambda-asg-on.zip"
}
