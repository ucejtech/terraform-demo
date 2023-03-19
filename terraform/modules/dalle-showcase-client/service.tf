resource "kubernetes_service" "dalleclient" {
  metadata {
    name = "dalleclient-service"

    labels = {
      "App" = "dalleclient"
    }
  }

  spec {
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }

    selector = {
      "App" = kubernetes_deployment.dalleclient.spec.0.template.0.metadata[0].labels.App
    }
  }
}

