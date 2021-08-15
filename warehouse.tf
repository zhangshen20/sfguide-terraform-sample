resource "snowflake_warehouse" "wh" {
  name = "${var.sf_wh_name}"
  warehouse_size = "small"
  auto_suspend   = 60
}
resource "snowflake_warehouse_grant" "grant" {
   warehouse_name    = snowflake_warehouse.wh.name
   privilege         = "USAGE"
   roles             = ["${var.sf_rl_name_loader}", "${var.sf_rl_name_transformer}"]
   with_grant_option = false
}
