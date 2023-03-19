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
      data.aws_eks_cluster.k8s_cluster.cluster_name
    ]
  }
}

resource "kubernetes_deployment" "dalleserver" {
  metadata {
    name = "dalleserver"
    labels = {
      "io.kompose.service" = "dalleserver"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        "io.kompose.service" = "dalleserver"
      }
    }
    template {
      metadata {
        labels = {
          "io.kompose.service" = "dalleserver"
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

