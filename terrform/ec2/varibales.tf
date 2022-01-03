variable "tag" {
    description = "Tag for EC2 instance"
    type = string
    default = "test_ec2"
}
variable "instance_type" {
    description = "The type of ec2 instance"
    type = string
    default =" t2.micro"
    }
variable "security_group_name" {
    description = "The name of the security group"
    type = string
    default = "test_ec2_sg"
}
variable "vpc_id" {
    description = "The VPC id for security group"
    type = string
    default = ""
}