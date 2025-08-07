
# Install ArgoCD using Helm
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = "argocd"
  version    = "8.2.5"

  create_namespace = true

  set = [
    {
      name  = "server.service.type"
      value = "NodePort"
    },
    {
      name  = "server.service.nodePortHttp"
      value = "30080"
    },
    {
      name  = "server.service.nodePortHttps"
      value = "30443"
    },
    {
      name  = "server.insecure"
      value = "true"
    },
    {
      name  = "configs.secret.argocdServerAdminPassword"
      value = "$2a$12$jsp1ERezNp3vtIlaUX6Cmu8mKz5jJKKBjuuImKeJN/liMUxmiUxcS" // bcrypt hash of 'admin'
    }
  ]

  depends_on = [kind_cluster.admin-cluster]
}