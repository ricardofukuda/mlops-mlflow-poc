variable "env" {
  type = string
  default = "infra"
}

variable "tags" {
  type = any
  default = {
    App = "kserve"
    Environment = "infra"
    Terraform = "true"
  }
}
