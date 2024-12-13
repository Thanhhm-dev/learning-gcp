resource "google_artifact_registry_repository" "web" {
  location      = var.location
  repository_id = var.name
  format        = "DOCKER"
  docker_config {
    immutable_tags = false
  }
}