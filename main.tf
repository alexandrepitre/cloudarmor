module "cloud_armor" {
  source = "./modules/cloud-armor"
  project_id = var.project
  name = var.security_policy
}
