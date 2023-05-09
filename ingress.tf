resource "kubernetes_ingress_v1" "loki" {
  metadata {
    name      = "loki"
    namespace = "monitoring"

    annotations = {
      # "kubernetes.io/ingress.class"                  = "nginx"
      "nginx.ingress.kubernetes.io/auth-secret"      = "loki-auth"
      "nginx.ingress.kubernetes.io/auth-type"        = "basic"
      "nginx.ingress.kubernetes.io/auth-realm"       = "Authentication Required"
      "nginx.ingress.kubernetes.io/service-upstream" = "true"
    }
  }

  spec {
    ingressClassName = "nginx"
    rule {
      host = var.loki_ingress_host

      http {
        path {
          path = "/"

          backend {
            service {
              name = "loki"
              port {
                number = 3100
              }
            }
          }
        }
      }
    }
  }
}
