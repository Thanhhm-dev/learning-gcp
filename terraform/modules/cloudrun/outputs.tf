output "cloud_run_url" {
  description = "URL của dịch vụ Cloud Run đã triển khai"
  value       = google_cloud_run_service.my_cloud_run_service.status[0].url
}
