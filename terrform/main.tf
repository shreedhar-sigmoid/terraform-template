module "lambda_module" {
  source = "./lambda"
}
module "kms" {
  source = "./kms"
}

resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     =  "${var.step_function_name}"
  role_arn = aws_iam_role.step_function_assume_role_policy.arn

  definition = <<EOF
{
  "Comment": "A Hello World example of the Amazon States Language using an AWS Lambda Function",
  "StartAt": "HelloWorld",
  "States": {
    "HelloWorld": {
      "Type": "Task",
      "Resource": "${module.lambda_module.lambda_function.arn}",
      "End": true
    }
  }
}
EOF 
}

resource "aws_iam_role_policy" "step_function_policy" {
  name    = "${var.step_function_name}_assume_role_policy"
  role    = aws_iam_role.step_function_assume_role_policy.id

  policy  = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "lambda:InvokeFunction"
        ],
        "Effect": "Allow",
        "Resource": "${module.lambda_module.lambda_function.arn}"
      }
    ]
  }
  EOF
}
resource "aws_iam_role" "step_function_assume_role_policy" {
  name               = "${var.step_function_name}_assume_role_policy"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "states.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": "StepFunctionAssumeRole"
      }
    ]
  }
  EOF
}
