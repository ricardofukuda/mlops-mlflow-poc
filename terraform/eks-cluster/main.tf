
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  create = true

  cluster_name = var.cluster_name
  cluster_version = "1.29"

  cluster_endpoint_public_access  = true # TEST ONLY
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access_cidrs = ["${chomp(data.http.icanhazip.body)}/32"] # restrict to my current public ip #TEST #TODO

  control_plane_subnet_ids = module.vpc.private_subnets

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = [] # empty to force each nodegroup to configure it

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
      service_account_role_arn = module.ebs_csi_role.iam_role_arn
    }
  }

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"

    subnet_ids = module.vpc.private_subnets # by default, we use private subnets

    network_interfaces = [
      {
        associate_public_ip_address = false # by default, we disable public IPs
      }
    ]
  }

  eks_managed_node_groups = {
    app = {
      min_size     = 1
      max_size     = 3
      desired_size = 3

      disk_size = 20

      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
    }
  }

  authentication_mode = "API_AND_CONFIG_MAP"
  enable_cluster_creator_admin_permissions = true

  create_kms_key = false # TEST ONLY
  kms_key_deletion_window_in_days = 7
  cluster_encryption_config = {}

  create_cloudwatch_log_group = false # disable cloudwatch logging
  cluster_enabled_log_types = [] # disable cloudwatch logging

  tags = var.tags

  node_security_group_additional_rules = {
    cluster_control_plane_to_nodes = {
      protocol = "-1"
      from_port = 0
      to_port = 0
      type = "ingress"
      source_cluster_security_group = true
      description = "cluster_control_plane_to_nodes"
    }
  }

  depends_on = [ module.vpc ]
}
