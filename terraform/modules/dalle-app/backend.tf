resource "kubernetes_deployment" "dalleserver" {
  metadata {
    name = "dalleserver"
    labels = {
      "App" = "dalleserver"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        "App" = "dalleserver"
      }
    }
    template {
      metadata {
        labels = {
          "App" = "dalleserver"
        }
      }
      spec {
        container {
          name  = "dalleserver"
          image = "${var.DOCKER_HUB_REPO}/dalle-server"

          port {
            container_port = 8080
          }
          env {
            name  = "CLOUDINARY_API_KEY"
            value = var.CLOUDINARY_API_KEY
          }
          env {
            name  = "CLOUDINARY_API_SECRET"
            value = var.CLOUDINARY_API_SECRET
          }
          env {
            name  = "CLOUDINARY_CLOUD_NAME"
            value = var.CLOUDINARY_CLOUD_NAME
          }
          env {
            name  = "MONGODB_URL"
            value = var.MONGODB_URL
          }
          env {
            name  = "OPENAI_API_KEY"
            value = var.OPENAI_API_KEY
          }
        }
        restart_policy = "Always"
      }
    }
  }
}

resource "kubernetes_service" "dalleserver" {
  metadata {
    name = "dalle-server-service"

    labels = {
      "App" = "dalleserver"
    }
  }

  spec {
    port {
      name        = "http"
      port        = 3000
      target_port = 8080
    }

    selector = {
      "App" = kubernetes_deployment.dalleserver.spec.0.template.0.metadata[0].labels.App
    }

    type = "ClusterIP"
  }
}

