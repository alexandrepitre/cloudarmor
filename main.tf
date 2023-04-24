module "cloud_amor" {
  source = "./modules/cloud-armor"
  project_id = var.project
  name = var.security_policy
}
