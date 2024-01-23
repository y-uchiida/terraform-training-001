# プロバイダー設定

# Terraform のバージョンとプロバイダーの設定
terraform {
  required_version = ">=1.7.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# AWS プロバイダーの設定
provider "aws" {
  profile = var.awsProfile
  region  = "ap-northeast-1"
}
