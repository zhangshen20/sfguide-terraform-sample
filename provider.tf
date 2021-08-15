provider "snowflake" {
  role     = "SYSADMIN"
}

provider "snowflake" {
   alias    = "security_admin"
   role     = "SECURITYADMIN"
}
