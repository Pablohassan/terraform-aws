terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# la région aws ou nous voulons déployer nos différentes ressources
provider "aws" {
  region     = "eu-west-3"
  access_key = "AKIAR22IPVNI2XSN3TW4"                     # la clé d'acces crée pour l'utilisateur qui sera utilisé par terraform
  secret_key = "p85aYW9Jo1c7r7TanO11mK/d0OgwDfVnmFcbtVoy" # la clé sécrète crée pour l'utilisateur qui sera utilisé par terraform
}
