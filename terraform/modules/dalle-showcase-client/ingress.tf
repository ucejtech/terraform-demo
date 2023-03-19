resource "kubernetes_ingress_v1" "frontend_ingress" {
  metadata {
    name = "dalle-client-ingress"

    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/$1"
    }
  }

  spec {
    rule {
      http {
        path {
          path      = "/"
          backend {
            service {
              name = "dalleclient-service"

              port {
                name = "http"
              }
            }
          }
        }
        path {
          path      = "/api(/|$)(.*)"
          path_type = "Prefix"
          backend {
            service {
              name = "dalleserver-service"

              port {
                name = "http"
              }
            }
          }
        }
      }
    }
  }
}

