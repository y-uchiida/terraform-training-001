# VPC の設定
# resource "aws_vpc" "識別名"
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

# サブネットの設定 - パブリックサブネット1
# resource "aws_subnet" "識別名"
resource "aws_subnet" "publicSubnet_1a" {

  # VPC の ID を設定
  vpc_id = aws_vpc.vpc.id

  # サブネットの CIDR ブロックを設定
  cidr_block = "192.168.1.0/24"

  # サブネットの AZ を設定
  availability_zone = "ap-northeast-1a"

  # サブネットのパブリック IP アドレスの自動割り当てを設定
  map_public_ip_on_launch = true

  # サブネットのタグを設定
  tags = {
    Name    = "${var.projectName}-${var.environment}-publicSubnet-1"
    Project = var.projectName
    Env     = var.environment
    Type    = "public"
  }
}

# サブネットの設定 - パブリックサブネット2
# resource "aws_subnet" "識別名"
resource "aws_subnet" "publicSubnet_1c" {

  # VPC の ID を設定
  vpc_id = aws_vpc.vpc.id

  # サブネットの CIDR ブロックを設定
  cidr_block = "192.168.2.0/24"

  # サブネットの AZ を設定
  availability_zone = "ap-northeast-1c"

  # サブネットのパブリック IP アドレスの自動割り当てを設定
  map_public_ip_on_launch = true

  # サブネットのタグを設定
  tags = {
    Name    = "${var.projectName}-${var.environment}-publicSubnet-2"
    Project = var.projectName
    Env     = var.environment
    Type    = "public"
  }
}

# サブネットの設定 - プライベートサブネット1
# resource "aws_subnet" "識別名"
resource "aws_subnet" "privateSubnet_1a" {

  # VPC の ID を設定
  vpc_id = aws_vpc.vpc.id

  # サブネットの CIDR ブロックを設定
  cidr_block = "192.168.3.0/24"

  # サブネットの AZ を設定
  availability_zone = "ap-northeast-1a"

  # サブネットのタグを設定
  tags = {
    Name    = "${var.projectName}-${var.environment}-privateSubnet-1"
    Project = var.projectName
    Env     = var.environment
  }
}

# サブネットの設定 - プライベートサブネット2
# resource "aws_subnet" "識別名"
resource "aws_subnet" "privateSubnet_1c" {

  # VPC の ID を設定
  vpc_id = aws_vpc.vpc.id

  # サブネットの CIDR ブロックを設定
  cidr_block = "192.168.4.0/24"

  # サブネットの AZ を設定
  availability_zone = "ap-northeast-1c"

  # サブネットのタグを設定
  tags = {
    Name    = "${var.projectName}-${var.environment}-privateSubnet-2"
    Project = var.projectName
    Env     = var.environment
  }
}

# ルートテーブルの設定 - パブリックルートテーブル
# resource "aws_route_table" "識別名"
resource "aws_route_table" "publicRouteTable" {

  # VPC の ID を設定
  vpc_id = aws_vpc.vpc.id

  # ルートテーブルのタグを設定
  tags = {
    Name    = "${var.projectName}-${var.environment}-publicRouteTable"
    Project = var.projectName
    Env     = var.environment
    Type    = "public"
  }
}

# ルートテーブルの設定 - プライベートルートテーブル
# resource "aws_route_table" "識別名"
resource "aws_route_table" "privateRouteTable" {

  # VPC の ID を設定
  vpc_id = aws_vpc.vpc.id

  # ルートテーブルのタグを設定
  tags = {
    Name    = "${var.projectName}-${var.environment}-privateRouteTable"
    Project = var.projectName
    Env     = var.environment
    Type    = "private"
  }
}

# ルートテーブルの紐付け(ルートテーブルアソシエーション) - AZ 1a のパブリックルートテーブル
# resource "aws_route_table_association" "識別名"
resource "aws_route_table_association" "publicRouteTableAssociation_1a" {

  # ルートテーブルの ID を設定
  route_table_id = aws_route_table.publicRouteTable.id

  # サブネットの ID を設定
  subnet_id = aws_subnet.publicSubnet_1a.id

}

# ルートテーブルの紐付け(ルートテーブルアソシエーション) - AZ 1c のパブリックルートテーブル
# resource "aws_route_table_association" "識別名"
resource "aws_route_table_association" "publicRouteTableAssociation_1c" {

  # ルートテーブルの ID を設定
  route_table_id = aws_route_table.publicRouteTable.id

  # サブネットの ID を設定
  subnet_id = aws_subnet.publicSubnet_1c.id

}

# ルートテーブルの紐付け(ルートテーブルアソシエーション) - AZ 1a のプライベートルートテーブル
# resource "aws_route_table_association" "識別名"
resource "aws_route_table_association" "privateRouteTableAssociation_1a" {

  # ルートテーブルの ID を設定
  route_table_id = aws_route_table.privateRouteTable.id

  # サブネットの ID を設定
  subnet_id = aws_subnet.privateSubnet_1a.id

}

# ルートテーブルの紐付け(ルートテーブルアソシエーション) - AZ 1c のプライベートルートテーブル
# resource "aws_route_table_association" "識別名"
resource "aws_route_table_association" "privateRouteTableAssociation_1c" {

  # ルートテーブルの ID を設定
  route_table_id = aws_route_table.privateRouteTable.id

  # サブネットの ID を設定
  subnet_id = aws_subnet.privateSubnet_1c.id

}
