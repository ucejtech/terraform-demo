resource "kubernetes_deployment" "dalleclient" {
  metadata {
    name = "dalleclient"

    labels = {
      "App" = "dalleclient"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "App" = "dalleclient"
      }
    }

    template {
      metadata {
        labels = {
          "App" = "dalleclient"
        }
      }

      spec {
        container {
          name  = "dalleclient"
          image = "${var.DOCKER_HUB_REPO}/dalle-client"

          port {
            container_port = 80
          }
        }

        restart_policy = "Always"
      }
    }
  }
}

resource "kubernetes_service" "dalleclient" {
  metadata {
    name = "dalle-client-service"

    labels = {
      "App" = "dalleclient"
    }
  }

  spec {
    port {
      name        = "http"
      port        = 8000
      target_port = 80
    }

    selector = {
      "App" = kubernetes_deployment.dalleclient.spec.0.template.0.metadata[0].labels.App
    }


    type = "ClusterIP"
  }
}

