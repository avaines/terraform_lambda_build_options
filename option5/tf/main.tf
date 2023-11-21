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

data "archive_file" "lambda" {
  type        = "zip"
  output_path = "archive/${var.name}_dummy_func.zip"

  source {
    filename = "main.py"
    content = <<-EOS
def lambda_handler(event,context):
    print()
EOS
  }
}

resource "aws_lambda_function" "lambda" {
  filename      = data.archive_file.lambda.output_path
  function_name = "${var.name}-lambda"
  role          = aws_iam_role.lambda.arn
  handler       = "main.lambda_handler"
  runtime       = "python3.11"

  source_code_hash = data.archive_file.lambda.output_base64sha256
}
