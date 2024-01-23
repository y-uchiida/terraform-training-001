# 生成するキーペアのアルゴリズム
variable "algorithm" {
  type    = string
  default = "RSA"
}

# 秘密鍵のビット数
variable "rsa_bits" {
  type    = number
  default = 2048
}

# キーペアの名前
# 空文字の場合は、現在の日付時刻から作成される
variable "key_name" {
  type    = string
  default = ""
}

# モジュール内部で利用するためのキーペア名
# 基本的には、変数 key_name と同じ値を設定する
# key_name の値が空文字列だった場合は、現在の日付時刻から文字列を作る
# 例: 2021-01-01-00-00-00
locals {
  key_name = var.key_name != "" ? var.key_name : "key_${formatdate("YYYY-MM-DD-hh-mm-ss", timestamp())}"
}

# キーペアを保存するパラメータストアのパス
variable "key_pair_parameter_store_path" {
  type    = string
  default = ""
}

# 内部的に利用するパラメータストアのパス
# 基本的には変数 key_pair_parameter_store_path と同じ値を設定する
# key_pair_parameter_store_path の値が空文字列だった場合は、local.key_name と同じ値を設定する
locals {
  key_pair_parameter_store_path = var.key_pair_parameter_store_path != "" ? var.key_pair_parameter_store_path : "/${local.key_name}"
}
