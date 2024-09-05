subnet_cidr_block = "172.31.96.0/20"
cidr_block = [
  { cidr_block = "10.0.0.0/16", name = "dev-vpc" },
  { cidr_block = "10.0.10.0/24", name = "dev-subnet" }
]
development = "development"
