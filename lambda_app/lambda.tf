resource "aws_lambda_function" "lambda" {
  function_name = "${var.app_name}"
  filename = "${var.filename}"
  handler = "index.handler"
  runtime = "nodejs12.x"
  timeout = 29
  memory_size = 1280
  role =  "${aws_iam_role.lambda_exec.arn}"
  depends_on = [aws_iam_role_policy_attachment.lambda_logs, aws_cloudwatch_log_group.lambda_log_group]
  environment {
    variables = var.lambda_environment_variables
  }
  source_code_hash = filebase64sha256("deploy.zip")
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.app_name}_exec_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

 resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "${var.app_name}/lambda"
  retention_in_days = "${var.log_retention_days}"
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "lambda_logging" {
  name        = "${var.app_name}_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = "${aws_iam_role.lambda_exec.name}"
  policy_arn = "${aws_iam_policy.lambda_logging.arn}"
}
