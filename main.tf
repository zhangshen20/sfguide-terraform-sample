terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "0.22.0"
    }
  }
}

resource "tls_private_key" "svc_key" {
   algorithm = "RSA"
   rsa_bits  = 2048
}
