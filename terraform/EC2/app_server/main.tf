# app_server.tf
# アプリケーションサーバーの作成を行う

# EC2 のキーペアリストに公開鍵を登録する
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = var.public_key
}

# アプリケーションサーバーインスタンスの作成
resource "aws_instance" "app_server" {

  # インスタンスの AMI を設定
  ami = var.ami_image_id

  # インスタンスのタイプを設定
  instance_type = var.instance_type

  # インスタンスのサブネットを設定
  subnet_id = var.subnet_id

  # インスタンスのセキュリティグループを設定
  vpc_security_group_ids = var.security_group_ids

  # パブリックIPアドレスの自動割当
  associate_public_ip_address = var.associate_public_ip_address

  # インスタンスのキーペアを設定
  key_name = var.key_name

  # インスタンスに設定するインスタンスプロフィール名を設定
  iam_instance_profile = var.instance_profile_name

  # インスタンスのタグを設定
  tags = {
    Name        = "${var.projectName}-${var.environment}-app-ec2"
    Project     = var.projectName
    Environment = var.environment
    Type        = "app"
  }
}
