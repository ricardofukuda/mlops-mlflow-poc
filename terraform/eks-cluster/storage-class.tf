resource "kubernetes_storage_class" "ebs_csi_gp3" {
  metadata {
    name = "gp3"
  }
  storage_provisioner     = "ebs.csi.aws.com"
  reclaim_policy          = "Delete"
  allow_volume_expansion  = true
  parameters = {
    type = "gp3"
  }

  depends_on = [ module.eks, module.ebs_csi_role ]
}
