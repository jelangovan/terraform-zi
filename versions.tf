terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "elangovanj-tfstate"
    key    = "tfstate/new-tf-state"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-1"
  }