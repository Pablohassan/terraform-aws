# on déclare l'étendue de la plage ip du VPC
variable "cidr_vpc" {
  description = "CIDR du VPC"
  default     = "10.1.0.0/16"

}

# on déclare l'étendue de la plage ip du reseau public a
variable "cidr_public_subnet_a" {
  description = "CIDR du Sous-réseau  public a"
  default     = "10.1.0.0/24"

}

variable "cidr_public_subnet_b" {
  description = "CIDR du Sous-réseau  public b"
  default     = "10.1.1.0/24"

}

# on déclare l'étendue de la plage ip du reseau privé a
variable "cidr_app_subnet_a" {
  description = "CIDR du Sous-réseau privé a"
  default     = "10.1.2.0/24"

}

variable "cidr_app_subnet_b" {
  description = "CIDR du Sous-réseau privé b"
  default     = "10.1.3.0/24"

}

variable "az_a" {
  description = "zone de disponibilité a"
  default     = "eu-west-3a"
}


variable "az_b" {
  description = "zone de disponibilité b"
  default     = "eu-west-3b"

}

variable "environment" {
  description = "environment variable"
  default     = "dev"
}