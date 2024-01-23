# project名を指定
variable "projectName" {
  type    = string
  default = "terraform"
}

# モジュール内で利用するproject の値を設定
# 基本的にはモジュール呼び出しの際に渡された値を使うが、
# 空文字列だった場合(=呼び出し側で値が設定されていなかった場合)は
# 現在の日付時刻から生成した値を使う
locals {
  projectName = var.projectName != "" ? var.projectName : "project-${timestamp()}"
}

# environment名を指定
variable "environment" {
  type    = string
  default = "default"
}

# AMI の ID を指定
variable "ami_image_id" {
  type = string
}

# インスタンスタイプを指定
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

# サブネットIDを指定
variable "subnet_id" {
  type = string
}

# セキュリティグループIDを指定
variable "security_group_ids" {
  type = list(string)
}

# パブリックIPアドレスの自動割当を指定
variable "associate_public_ip_address" {
  type    = bool
  default = true
}

# インスタンスに設定するキーペア名を指定
variable "key_name" {
  type = string
}

# EC2のキーペアリストに登録する公開鍵の内容を指定
variable "public_key" {
  type = string
}
