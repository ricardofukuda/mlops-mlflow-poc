variable "env" {
  type = string
  default = "infra"
}

variable "tags" {
  type = any
  default = {
    App = "cert-manager"
    Environment = "infra"
    Terraform = "true"
  }
}
