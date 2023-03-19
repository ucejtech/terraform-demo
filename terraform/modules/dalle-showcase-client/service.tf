resource "kubernetes_service" "dalleclient" {
  metadata {
    name = "dalleclient-service"

    labels = {
      "io.kompose.service" = "dalleclient"
    }
  }

  spec {
    port {
      name        = "http"
      port        = 80
      target_port = "80"
    }

    selector = {
      "io.kompose.service" = "dalleclient"
    }
  }
}

