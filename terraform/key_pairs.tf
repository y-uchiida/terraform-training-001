# app_server に設定するキーペアの作成
module "app_server_key_pair" {
  source    = "./modules/create_key_pair"
  key_name  = "${var.projectName}-${var.environment}-app-server-key"
  rsa_bits  = 4096
  algorithm = "ED25519"
}

# 踏み台サーバー(bastion) に設定するキーペアの作成
module "bastion_key_pair" {
  source    = "./modules/create_key_pair"
  key_name  = "${var.projectName}-${var.environment}-bastion-key"
  rsa_bits  = 4096
  algorithm = "ED25519"
}
