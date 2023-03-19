resource "kubernetes_service" "dalleserver" {
  metadata {
    name = "dalleserver-service"

    labels = {
      "io.kompose.service" = "dalleserver"
    }
  }

  spec {
    port {
      name        = "http"
      port        = 3000
      target_port = "8080"
    }

    selector = {
      "io.kompose.service" = kubernetes_deployment.dalleserver.spec.0.template.metadata[0].labels["io.kompose.service"]
    }
  }
}

