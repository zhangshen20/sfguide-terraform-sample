locals {
  users = {
    "${var.sf_ur_name_mac}" = {
      login_name = "${var.sf_ur_name_mac}"
      role       = "${var.sf_rl_name_loader}"
      namespace  = "${snowflake_database.db.name}.${var.sf_sh_name_raw}"
      warehouse  = "${snowflake_warehouse.wh.name}"
    }
    "${var.sf_ur_name_cheese}" = {
      login_name = "${var.sf_ur_name_cheese}"
      role       = "${var.sf_rl_name_transformer}"
      namespace  = "${snowflake_database.db.name}.${var.sf_sh_name_analytics}"
      warehouse  = "${snowflake_warehouse.wh.name}"
    }
    "${var.sf_ur_name_stitch}" = {
      login_name = "${var.sf_ur_name_stitch}"
      role       = "${var.sf_rl_name_transformer}"
      namespace  = "${snowflake_database.db.name}.${var.sf_sh_name_analytics}"
      warehouse  = "${snowflake_warehouse.wh.name}"
    }
  }
}

resource "snowflake_user" "user" {
  provider             = snowflake.security_admin    
  for_each             = local.users
  name                 = each.key
  login_name           = each.value.login_name
  default_role         = each.value.role
  default_namespace    = each.value.namespace
  default_warehouse    = each.value.warehouse
  password              = "Welcome1"
  must_change_password = false
}
