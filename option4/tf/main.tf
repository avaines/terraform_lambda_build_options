locals {
  default_tags = {
      Project = "lambda deployment mechanism poc"
      Name    = var.name
  }

  function_name = "test_func"
}

data "external" "git" {
  program = [
    "git",
    "log",
    "--pretty=format:{ \"sha\": \"%H\" }",
    "-1",
    "HEAD"
  ]
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

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${path.module}/../../src/${local.function_name}"
  output_path = "archive/${var.name}_${local.function_name}.zip"
}

resource "aws_s3_object" "lambda" {
  bucket = var.function_s3_bucket_name
  key    = "${local.function_name}.zip"
  source = data.archive_file.lambda.output_path

  etag = filemd5(data.archive_file.lambda.output_path)

  metadata = {
    hash = filebase64sha256(data.archive_file.lambda.output_path)
    function = local.function_name
    commit = try(data.external.git.result["sha"], "null")
  }
}

resource "aws_lambda_function" "lambda" {
  s3_bucket     = var.function_s3_bucket_name
  s3_key        = aws_s3_object.lambda.key
  function_name = "${var.name}-lambda"
  role          = aws_iam_role.lambda.arn
  handler       = "main.lambda_handler"
  runtime       = "python3.11"

  source_code_hash = aws_s3_object.lambda.metadata["commit"] == data.external.git.result["sha"] ? (var.force_lambda_code_deploy ? aws_s3_object.lambda.metadata["hash"] : null) : aws_s3_object.lambda.metadata["hash"]
}
