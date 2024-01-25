# 変数の定義 - プロジェクト名
variable "projectName" {
  type = string
}

# 変数の定義 - 環境名
variable "environment" {
  type = string
}

# 使用するAWSプロファイル名の設定
variable "awsProfile" {
  type = string
}

# 使用するAWSリージョンの設定
variable "awsRegion" {
  type = string
}

# tfstate ファイルを保存するS3バケット名の設定
variable "tfstateBucket" {
  type = string
}
