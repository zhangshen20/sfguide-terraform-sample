locals {
  roles = {
    "${var.sf_rl_name_loader}" = {
      comment = "Owns the tables in raw schema"
      name = "${var.sf_rl_name_loader}"
    }
    "${var.sf_rl_name_transformer}" = {
      comment = "Has query permissions on tables in raw schema and owns tables in the analytics schema."
      name = "${var.sf_rl_name_transformer}"
    }
  }  
}

locals {
  role_grants = {
      "${var.sf_rl_name_loader}" = {
          users = ["${var.sf_ur_name_mac}"]
      }
      "${var.sf_rl_name_transformer}" = {
          users = ["${var.sf_ur_name_cheese}", "${var.sf_ur_name_stitch}"]
      }
  }
}

resource "snowflake_role" "role" {
  provider = snowflake.security_admin
  for_each = local.roles
  name     = each.key
  comment  = each.value.comment
}

resource "snowflake_role_grants" "role_grants" {
  provider  = snowflake.security_admin    
  for_each  = local.role_grants
  role_name = snowflake_role.role[each.key].name
  users     = [for user_name in each.value.users: snowflake_user.user[user_name].name]

}







