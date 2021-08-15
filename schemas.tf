locals {
  schemas = {
    "${var.sf_sh_name_raw}" = {
      database = "${snowflake_database.db.name}"
      comment = "contains raw data from our source systems"
      usage_roles = ["${var.sf_rl_name_loader}"]
      all_roles = ["${var.sf_rl_name_loader}"]
    }
    "${var.sf_sh_name_analytics}" = {
      database = "${snowflake_database.db.name}"
      comment = "contains tables and views accessible to analysts and reporting"
      usage_roles = ["${var.sf_rl_name_transformer}"]
      all_roles = ["${var.sf_rl_name_transformer}"]
    }
  }
}

resource "snowflake_schema" "schema" {
  for_each = local.schemas
  database = each.value.database
  name     = each.key  
  comment  = each.value.comment
}

resource "snowflake_schema_grant" "grant" {
  for_each      = local.schemas
  database_name = each.value.database  
  schema_name   = snowflake_schema.schema[each.key].name
  privilege     = "USAGE"
  roles         = each.value.usage_roles
  shares        = []
  with_grant_option = false
}

resource "snowflake_schema_grant" "schema_grant_create_table" {
  for_each      = local.schemas
  schema_name   = each.key
  database_name = each.value.database
  privilege     = "CREATE TABLE"
  roles         = each.value.all_roles
  shares        = []
}