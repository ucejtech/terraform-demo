resource "kubernetes_service" "app_k8s_nginx_service" {
  metadata {
    name = "${var.name}-nginx-service"
  }
  spec {
    selector = {
      App = kubernetes_deployment.app_k8s_nginx.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }

}
