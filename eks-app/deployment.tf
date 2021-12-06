# variable image_name {}
# variable tag {}

resource "kubernetes_deployment" "nginx-app" {
  metadata {
    name = "scalable-nginx-deployment"
    labels = {
      App = "pccm-nginx"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "pccm-nginx"
      }
    }
    template {
      metadata {
        labels = {
          App = "pccm-nginx"
        }
      }
      spec {
        container {
          image = "766212600052.dkr.ecr.ap-southeast-1.amazonaws.com/pccm-cluster-app-repo:latest"
          #image = "766212600052.dkr.ecr.ap-southeast-1.amazonaws.com/${var.image_name}:latest"
          name  = "pccm-nginx"

          port {
            container_port = 8080
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

