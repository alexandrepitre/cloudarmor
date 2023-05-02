


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

    "sqli_sensitivity_level_4" = {
      action          = "deny(502)"
      priority        = 1
      target_rule_set = "sqli-v33-stable"
    }

    "xss-stable_level_2_with_exclude" = {
      action                  = "throttle"
      priority                = 2
      description             = "XSS Sensitivity Level 2 with excluded rules"
      preview                 = true
      target_rule_set         = "xss-v33-stable"
      sensitivity_level       = 2
      exclude_target_rule_ids = ["owasp-crs-v030301-id941380-xss", "owasp-crs-v030301-id941340-xss"]
      rate_limit_options = {
        exceed_action                        = "deny(502)"
        rate_limit_http_request_count        = 10
        rate_limit_http_request_interval_sec = 60
      }
    }

    "php-stable_level_1_with_include" = {
      action                  = "rate_based_ban"
      priority                = 3
      description             = "PHP Sensitivity Level 1 with included rules"
      target_rule_set         = "xss-v33-stable"
      sensitivity_level       = 0
      include_target_rule_ids = ["owasp-crs-v030301-id933190-php", "owasp-crs-v030301-id933111-php"]
      exclude_target_rule_ids = []
      rate_limit_options = {
        ban_duration_sec                     = 600
        enforce_on_key                       = "ALL"
        exceed_action                        = "deny(502)"
        rate_limit_http_request_count        = 10
        rate_limit_http_request_interval_sec = 60
        ban_http_request_count               = 1000
        ban_http_request_interval_sec        = 300
      }
    }

    "rfi_sensitivity_level_4" = {
      action          = "redirect"
      priority        = 4
      description     = "Remote file inclusion 4"
      redirect_type   = "GOOGLE_RECAPTCHA"
      target_rule_set = "rfi-v33-stable"
    }

  }
}