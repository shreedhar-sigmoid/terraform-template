resource "aws_kms_key" "my_kms_key" {
  customer_master_key_spec = var.key_spec
  is_enabled               = var.enabled

  policy = <<EOF
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1640755914345",
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*" ,
      "Principal": "*"
    }
  ]
}
EOF
}

resource "aws_kms_alias" "my_kms_alias" {
  target_key_id = aws_kms_key.my_kms_key.key_id
  name          = "alias/${var.kms_alias}"
}
