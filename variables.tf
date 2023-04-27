variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "security_policy" {
  type = string
  default = "alex-security-policy"
}

variable "prefix" {
  default = "bob"
}
