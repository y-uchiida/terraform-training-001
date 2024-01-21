# VPC の設定
resource "aws_vpc" "vpc" {

  # VPC の CIDR ブロックを設定
  cidr_block = "192.168.0.0/20"

  # tenancy の設定
  # default の場合、AWS が提供するテナントに VPC を作成する
  instance_tenancy = "default"

  # VPC 内での DNS サポートの設定
  # true の場合、VPC 内での DNS サポートを有効にする
  enable_dns_support = true

  # VPC 内での DNS ホスト名の設定
  # true の場合、VPC 内での DNS ホスト名を有効にする
  enable_dns_hostnames = true

  # IPv6 の設定
  assign_generated_ipv6_cidr_block = false

  # AWS 内で識別を行うためのタグを設定
  tags = {
    Name    = "${var.projectName}-${var.environment}-vpc"
    Project = var.projectName
    Env     = var.environment
  }
}
