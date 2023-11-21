locals {
    default_tags = {
        Project = "lambda deployment mechanism poc"
        Name    = var.name
    }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda" {
  name               = "${var.name}-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_s3_object" "lambda" {
  bucket = var.function_s3_bucket_name
  key    = "test_func.zip"
}

resource "aws_lambda_function" "lambda" {
  filename      = data.aws_s3_object.lambda.key
  function_name = "${var.name}-lambda"
  role          = aws_iam_role.lambda.arn
  handler       = "main.lambda_handler"
  runtime       = "python3.11"

  source_code_hash = data.aws_s3_object.lambda.metadata[var.function_deploy_trigger_key]
}
