resource "kubernetes_persistent_volume_claim" "mongo_pvc" {
  metadata {
    name = "mongo-pvc"
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "256Mi"
      }
    }
  }
}

resource "kubernetes_service" "mongo" {
  metadata {
    name = "mongo"
  }

  spec {
    port {
      port        = 27017
      target_port = "27017"
    }

    selector = {
      app = "mongo"
    }
  }
}

resource "kubernetes_deployment" "mongo" {
  metadata {
    name = "mongo"
  }

  spec {
    selector {
      match_labels = {
        app = "mongo"
      }
    }

    template {
      metadata {
        labels = {
          app = "mongo"
        }
      }

      spec {
        volume {
          name = "storage"

          persistent_volume_claim {
            claim_name = "mongo-pvc"
          }
        }

        container {
          name  = "mongo"
          image = "mongo:6.0.2-focal"

          port {
            container_port = 27017
          }

          volume_mount {
            name       = "storage"
            mount_path = "/data/db"
          }
        }
      }
    }
  }
}

