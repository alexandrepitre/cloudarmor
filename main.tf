


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
  pre_configured_rules {
    name = "xss"
  }
  pre_configured_rules {
    name = "sql-injection"
  }
  pre_configured_rules {
    name = "lfi-rfi"
  }
  pre_configured_rules {
    name = "sqli"
  }
  pre_configured_rules {
    name = "sqli-err"
  }
  pre_configured_rules {
    name = "rfi-lfi-err"
  }
  pre_configured_rules {
    name = "dos-app-layer"
  }
  pre_configured_rules {
    name = "dos-network-layer"
  }
  pre_configured_rules {
    name = "admin-ddos"
  }
  pre_configured_rules {
    name = "http-protocol-violations"
  }
}
