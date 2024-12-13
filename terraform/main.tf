resource "random_string" "image_tag" {
 length  = 16
 special = false
}

locals {
  docker_image_tag = substr(md5(random_string.image_tag.result), 0, 16)
  web_image_url    = "${var.location}-docker.pkg.dev/${var.project_id}/${var.name}/web:${local.docker_image_tag}"
}

# Artifact Registry
module "registry" {
  source       = "./modules/registry"
  name = var.name
  location = var.location
  web_image_url = local.web_image_url

}

# Thay thế cho việc build thủ công 1 image
resource "null_resource" "docker_build_web" {
  provisioner "local-exec" {
    command = "cd ../ && docker build --platform linux/amd64 -t ${local.web_image_url} ."
  }
  depends_on = [module.registry]
}

# push image
resource "null_resource" "docker_push_web" {
  provisioner "local-exec" {
    command = "docker push ${local.web_image_url}"
  }
  depends_on = [
    null_resource.docker_build_web
  ]
}

# CloudRun
module "cloud_run" {
  source                = "./modules/cloudrun"
  name = var.name
  location = var.location
  web_image_url         = local.web_image_url
  depends_on = [
    null_resource.docker_push_web
  ]
}
