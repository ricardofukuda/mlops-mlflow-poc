variable "env" {
  type = string
  default = "infra"
}

variable "tags" {
  type = any
  default = {
    App = "mlflow"
    Environment = "infra"
    Terraform = "true"
  }
}

variable "domain" {
  type = string
}