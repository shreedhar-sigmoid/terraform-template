output "lambda_assume_role_policy" {
  value = aws_iam_role.lambda_assume_role_policy
}
output "lambda_function" {
  value = aws_lambda_function.lambda_function
}
