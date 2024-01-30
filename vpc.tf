### Creation du vpc datascientest
resource "aws_vpc" "datascientest_vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "datascientest-vpc"
  }
}



