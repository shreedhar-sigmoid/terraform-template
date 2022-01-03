module "kms" {
  source = "./kms"
}

module "step_funtions" {
  source = "./step_function"
}
module "ec2" {
  source = "./ec2"
}
module "sns" {
  source = "./sns"
}