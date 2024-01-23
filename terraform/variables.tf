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

# 使用するAWSプロファイル名の設定
variable "awsProfile" {
  type    = string
  default = "default"
}
