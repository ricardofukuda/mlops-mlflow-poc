variable "env" {
  type = string
  default = "infra"
}

variable "tags" {
  type = any
  default = {
    App = "knative"
    Environment = "infra"
    Terraform = "true"
  }
}
