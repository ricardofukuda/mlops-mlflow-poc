data "aws_eks_cluster" "eks" {
  name = "eks-${var.env}"
}

data "aws_eks_cluster_auth" "eks_auth" {
  name =  data.aws_eks_cluster.eks.name
}

data "aws_vpc" "vpc"{
  tags = {
    Name = "eks-${var.env}"
  }
}

data "template_file" "values" {
  template = file("config/values.yml")
  vars = {
    domain = var.domain
  }
}

data "aws_route53_zone" "public" {
  name = var.domain
  private_zone = false
}

data "kubernetes_service" "ingress" {
  metadata {
    name      = "istio-ingressgateway"
    namespace = "istio-system"
  }
}
