terraform {
  required_version = ">= 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 3.0"
    }
  }

  # The bucket you created by hand in step 0. Backends can't use variables, write the values here.
  backend "s3" {
    bucket       = "csepella-csk-x-362099375729-eu-west-3-an"
    key          = "infra-code/terraform.tfstate"
    region       = "eu-west-3"
    use_lockfile = true
  }
}

provider "aws" {
  region = "eu-west-3"
}
