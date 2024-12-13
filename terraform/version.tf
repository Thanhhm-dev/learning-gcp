# Định cấu hình nhà cung cấp dịch vụ là Google Cloud Platform
provider "google" {
  project = var.project_id
  region  = "us-east-1"
  credentials = file("google-credentials.json")
}