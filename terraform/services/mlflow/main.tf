resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "mlflow-inference"

    labels = {
      "istio-injection" = "enabled"
    }
  }
}

# https://artifacthub.io/packages/helm/bitnami/mlflow/1.0.2
resource "helm_release" "mlflow" {
  name       = "mlflow"
  create_namespace = true

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mlflow"
  namespace  = "mlflow"
  version    = "1.0.2"

  values = [data.template_file.values.rendered]
}