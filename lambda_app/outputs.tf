output "invoke_arn" {
  value = "${aws_lambda_function.lambda.invoke_arn}"
}

output "function_name" {
  value = "${aws_lambda_function.lambda.function_name}"
}

output "role_arn" {
  value = "${aws_iam_role.lambda_exec.arn}"
}
