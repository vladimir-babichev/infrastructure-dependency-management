variable common_name  {}
variable country      {}
variable organization {}
variable ou           {}
variable path         {}
variable vault_addr   {}

variable exclude_cn_from_sans  {default = true}
variable key_bits              {default = 4096}
variable max_lease_ttl_seconds {default = 315360000}  # 10 years
variable type                  {default = "internal"}
