cluster_name = "eks-infra"
vpc_cird = "12.0.0.0/16"
azs = ["us-east-1c", "us-east-1d", "us-east-1f"]
tags = {
  Service = "infra"
  Terraform = true
  Environment = "infra"
}