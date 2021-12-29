variable key_spec {
  description = "The customer master key specification"
  type = string
  default = "SYMMETRIC_DEFAULT"
}
variable enabled {
  description = "Specifies whether the key is enabled"
  type = bool
  default = true
}

variable kms_alias {
  description = "The display name of the alias"
  type = string
  default = "test_kms_alias"
}
