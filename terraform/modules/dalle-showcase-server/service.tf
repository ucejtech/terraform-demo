resource "kubernetes_service" "dalleserver" {
  metadata {
    name = "dalleserver-service"

    labels = {
      "App" = "dalleserver"
    }
  }

  spec {
    port {
      name        = "http"
      port        = 3000
      target_port = "8080"
    }

    selector = {
      "App" = kubernetes_deployment.dalleserver.spec.0.template.0.metadata[0].labels.App
    }
  }
}

