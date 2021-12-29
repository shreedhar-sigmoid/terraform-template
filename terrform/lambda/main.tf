
resource "aws_lambda_function" "lambda_function" {
  function_name = "${var.lambda_function_name}"
  filename = data.archive_file.lambda_zip_file.output_path
  source_code_hash = data.archive_file.lambda_zip_file.output_base64sha256
  handler = "handler.handler"
  role = aws_iam_role.lambda_assume_role_policy.arn
  runtime = "python3.8"
}

data "archive_file" "lambda_zip_file" {
  output_path = "${path.module}/lambda_zip/lambda.zip"
  source_dir  = "${path.module}/../lambda/handler"
  type        = "zip"
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.lambda_function_name}_policy"
  role = aws_iam_role.lambda_assume_role_policy.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "lambda:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

}

resource "aws_iam_role" "lambda_assume_role_policy" {
  name =  "${var.lambda_function_name}_assume_role_policy"
  assume_role_policy = <<-EOF
  {
    "Version" : "2012-10-17" ,
    "Statement" : [
      {
        "Action" : "sts:AssumeRole" ,
        "Effect" : "Allow" ,
        "Sid"   : "" ,
        "Principal" : {
        "Service" : "lambda.amazonaws.com" 
        }
      }
    ]
  }
  EOF
}

