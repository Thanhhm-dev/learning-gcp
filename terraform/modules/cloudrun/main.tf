# Tạo một dịch vụ Cloud Run
resource "google_cloud_run_service" "my_cloud_run_service" {
  name     = var.name
  location = var.location

  template {
    spec {
      containers {
        image = var.web_image_url
        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}