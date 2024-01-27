# 各モジュールの呼び出し

# ----- app_server の作成 ---- #
module "app_server" {
  source = "./EC2/app_server"
  # プロジェクト名
  projectName = var.projectName
  # 環境名
  environment = var.environment
  # AMI イメージ ID
  ami_image_id = data.aws_ami.appServerAMI.id
  # インスタンスタイプ
  instance_type = "t2.micro"
  # サブネット ID
  subnet_id = aws_subnet.publicSubnet_1a.id
  # セキュリティグループ ID
  security_group_ids = [
    aws_security_group.SecurityGroup_appServer.id,
    aws_security_group.SecurityGroup_operationManagement.id
  ]
  # パブリック IP アドレスの自動割当
  associate_public_ip_address = true
  # キーペア名
  key_name = module.app_server_key_pair.key_name
  # 公開鍵
  public_key = module.app_server_key_pair.public_key_pem
  # インスタンスプロフィール名
  instance_profile_name = aws_iam_instance_profile.app_iam_instance_profile.name
}

# ----- bastion の作成 ---- #
module "bastion" {
  source = "./EC2/bastion"
  # プロジェクト名
  projectName = var.projectName
  # 環境名
  environment = var.environment
  # AMI イメージ ID
  ami_image_id = data.aws_ami.bastionAMI.id
  # インスタンスタイプ
  instance_type = "t2.micro"
  # サブネット ID
  subnet_id = aws_subnet.publicSubnet_1a.id
  # セキュリティグループ ID
  security_group_ids = [
    aws_security_group.SecurityGroup_operationManagement.id
  ]
  # パブリック IP アドレスの自動割当
  associate_public_ip_address = true
  # キーペア名
  key_name = module.bastion_key_pair.key_name
  # 公開鍵
  public_key = module.bastion_key_pair.public_key_pem
}
