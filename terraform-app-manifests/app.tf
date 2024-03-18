resource "kubernetes_deployment_v1" "app" {
  metadata {
    name = "node-app"
    labels = {
      app = "node"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "node"
      }
    }

    template {
      metadata {
        labels = {
          app = "node"
        }
      }

      spec {
        container {
          image = var.app_image_name
          name  = "node-app"
          port {
            container_port = 8080
          }
          env {
            name  = "DB_HOST"
            value = "mysql"
          }
          env {
            name  = "DB_USER"
            value = "mysql"
          }
          env {
            name  = "DB_PASSWORD"
            value = "123456"
          }
          env {
            name  = "DB_NAME"
            value = "tutorial_db"
          }
          env {
            name  = "DB_PORT"
            value = "3306"
          }
          env {
            name  = "APP_PORT"
            value = "8080"
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

resource "kubernetes_service" "app" {
  metadata {
    name = "app"
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.app.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}