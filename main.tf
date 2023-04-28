module "cloud_armor" {
  source = "./modules/cloud-armor"
  project_id = var.project_id
  name = var.policy_name
  description = var.policy_description
  layer_7_ddos_defense_enable = true
  layer_7_ddos_defense_rule_visibility = "STANDARD"
}
