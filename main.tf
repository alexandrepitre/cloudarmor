


module "cloud_armor" {
  source = "./modules/cloud-armor"
  project_id = var.project_id
  name = var.policy_name
  description = var.policy_description

  json_parsing = "STANDARD"
  #Enable Adaptive Protection
  layer_7_ddos_defense_enable = true
  layer_7_ddos_defense_rule_visibility = "STANDARD"

  default_rule_action          = "deny(404)"
  #Add pre-configured rules
  #Set target to lb backend
  pre_configured_rules = {

  "php-stable_level_1_with_include" = {
    action                  = "deny(502)"
    priority                = 3
    description             = "PHP Sensitivity Level 1 with included rules"
    target_rule_set         = "xss-v33-stable"
    sensitivity_level       = 0
    include_target_rule_ids = ["owasp-crs-v030301-id933190-php", "owasp-crs-v030301-id933111-php"]
  }

  "rfi_sensitivity_level_4" = {
    action                  = "redirect"
    priority                = 4
    description             = "Remote file inclusion 4"
    preview                 = true
    redirect_type           = "GOOGLE_RECAPTCHA"
    target_rule_set         = "rfi-v33-stable"
    sensitivity_level       = 4
  }

  }
}