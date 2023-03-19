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

resource "kubernetes_deployment" "dalleclient" {
  metadata {
    name = "dalleclient"

    labels = {
      "io.kompose.service" = "dalleclient"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "io.kompose.service" = "dalleclient"
      }
    }

    template {
      metadata {
        labels = {
          "io.kompose.service" = "dalleclient"
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

