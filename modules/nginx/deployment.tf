data "aws_eks_cluster" "k8s_cluster" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.k8s_cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      var.cluster_name
    ]
  }
}


resource "kubernetes_deployment" "app_k8s_nginx" {
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
