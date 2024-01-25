# プロバイダー設定

# Terraform のバージョンとプロバイダーの設定
terraform {
  required_version = ">=1.7.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  # バックエンドの設定
  # 設定値は .envrcで設定した TF_CLI_ARGS_init を参照する
  backend "s3" {}
}

# AWS プロバイダーの設定
provider "aws" {
  profile = var.awsProfile
  region  = "ap-northeast-1"
}
