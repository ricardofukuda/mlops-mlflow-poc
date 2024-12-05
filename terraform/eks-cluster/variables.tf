variable "cluster_name" {
  type = string
}

variable "vpc_cird" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}