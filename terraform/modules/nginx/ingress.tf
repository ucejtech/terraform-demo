resource "kubernetes_ingress" "dalle_ingress" {
  metadata {
    name = "dalle-ingress"

    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/api"

          backend {
            service_name = "dalleserver-service"
            service_port = "3000"
          }
        }

        path {
          path = "/"

          backend {
            service_name = "dalleclient-service"
            service_port = "80"
          }
        }
      }
    }
  }
}

