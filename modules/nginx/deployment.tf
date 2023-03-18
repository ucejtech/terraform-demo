

resource "kubernetes_deployment" "ucejtech_nginx" {
  metadata {
    name = "${var.name}-nginx"
    labels = {
      App = "${var.name}nginxtest"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "${var.name}nginxtest"
      }
    }
    template {
      metadata {
        labels = {
          App = "${var.name}nginxtest"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "${var.name}nginxtest"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

# resource "null_resource" "depends_on_resource" {
#   depends_on = [var.kubernetes_trigger]
# }
