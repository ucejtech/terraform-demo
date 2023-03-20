output "lb_ip" {
  value = kubernetes_service.dalle_k8s_nginx_service.status.0.load_balancer.0.ingress.0.hostname
}
