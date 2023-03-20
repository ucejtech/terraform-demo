resource "kubernetes_config_map" "nginx_config" {
  metadata {
    name = "nginx-config"
  }

  data = {
    "nginx.conf" = "server {\n    listen 80;\n    root /srv/www/static;\n    \n    location / {\n        proxy_pass http://dalleclient-service:8000;\n    }\n    location /api {\n        proxy_pass http://dalleserver-service:3000;\n    }\n}\n"
  }
}

resource "kubernetes_deployment" "dalle_k8s_nginx" {
  metadata {
    name = "${var.name}-nginx"
    labels = {
      App = "${var.name}nginxtest"
    }
  }

  spec {
    replicas = 1
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
        volume {
          name = "nginx-config"

          config_map {
            name = "nginx-config"
          }
        }
        container {
          image = "nginx:1.7.8"
          name  = "${var.name}nginxtest"

          port {
            container_port = 80
          }

          volume_mount {
            name       = "nginx-config"
            mount_path = "/etc/nginx/conf.d"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "dalle_k8s_nginx_service" {
  metadata {
    name = "${var.name}-nginx-service"
  }
  spec {
    selector = {
      App = kubernetes_deployment.dalle_k8s_nginx.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
