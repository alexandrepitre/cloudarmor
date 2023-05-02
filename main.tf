


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
  preconfigured_rules {
    name = "xss"
  }
  preconfigured_rules {
    name = "sql-injection"
  }
  preconfigured_rules {
    name = "lfi-rfi"
  }
  preconfigured_rules {
    name = "sqli"
  }
  preconfigured_rules {
    name = "sqli-err"
  }
  preconfigured_rules {
    name = "rfi-lfi-err"
  }
  preconfigured_rules {
    name = "dos-app-layer"
  }
  preconfigured_rules {
    name = "dos-network-layer"
  }
  preconfigured_rules {
    name = "admin-ddos"
  }
  preconfigured_rules {
    name = "http-protocol-violations"
  }
}
