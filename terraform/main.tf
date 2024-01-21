# ------------------------------------------------------------------------------
# Simple template of Terraform configuration file for the AWS infrastructure
# ------------------------------------------------------------------------------

# Terraform のバージョンを指定
terraform {
  required_version = ">=1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# AWS プロバイダーの設定
provider "aws" {
  profile = "terraform"
  region  = "ap-northeast-1"
}

# 変数の定義 - プロジェクト名
variable "projectName" {
  type    = string
  default = "terraformTraining001"
}

# 変数の定義 - 環境名
variable "environment" {
  type    = string
  default = "dev"
}
