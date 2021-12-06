resource "kubernetes_service" "nginx-app-svc" {
  metadata {
    name = "nginx-example"
    # annotations =  {
    #   "service.beta.kubernetes.io/aws-load-balancer-type": "nlb"
    # }

  }
  spec {
    selector = {
      App = kubernetes_deployment.nginx-app.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8080
    }

    type = "NodePort"
  }
}

resource "kubernetes_ingress" "common-ingress" {
  wait_for_load_balancer = true
  metadata {
    name = "common-ingress"
    annotations = {
      "kubernetes.io/ingress.class" : "alb"
      "alb.ingress.kubernetes.io/scheme": "internet-facing"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/*"
          backend {
            service_name = kubernetes_service.nginx-app-svc.metadata.0.name
            service_port = 80
          }
        }
      }
    }
  }
}

output "lb_dns" {
  value = kubernetes_ingress.common-ingress.hostname
 }
