resource "snowflake_database" "db" {
  name = "${var.sf_db_name}"
}

resource "snowflake_database_grant" "grant" {
   database_name     = snowflake_database.db.name
   privilege         = "USAGE"
   roles             = ["${var.sf_rl_name_loader}", "${var.sf_rl_name_transformer}"]
   with_grant_option = false
}