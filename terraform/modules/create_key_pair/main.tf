# 秘密鍵のアルゴリズムを設定
# variables.tf で定義した変数を使用
resource "tls_private_key" "keygen" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

# AWS のパラメータストアに秘密鍵を登録する
resource "aws_ssm_parameter" "private_key" {
  name  = "${local.key_pair_parameter_store_path}/private-key"
  type  = "SecureString"
  value = tls_private_key.keygen.private_key_pem
}

# AWS のパラメータストアに公開鍵を登録する
resource "aws_ssm_parameter" "public_key" {
  name  = "${local.key_pair_parameter_store_path}/public-key"
  type  = "String"
  value = tls_private_key.keygen.public_key_openssh
}
