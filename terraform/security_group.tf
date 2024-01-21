# Web サーバー用のセキュリティグループ
# resource "aws_security_group" "識別名"
resource "aws_security_group" "SecurityGroup_webServer" {

  # セキュリティグループの名前を設定
  name = "${var.projectName}-${var.environment}-SecurityGroup_webServer"

  # セキュリティグループの説明を設定
  description = "security group for web servers"

  # VPC の ID を設定
  vpc_id = aws_vpc.vpc.id

  # セキュリティグループのタグを設定
  tags = {
    Name    = "${var.projectName}-${var.environment}-SecurityGroup_webServer"
    Project = var.projectName
    Env     = var.environment
  }
}

# Web サーバー用のセキュリティグループのインバウンドルールを設定 - http
# resource "aws_security_group_rule" "識別名"
resource "aws_security_group_rule" "SecurityGroup_webServer_inbound_http" {

  # 接続するセキュリティグループのIDを設定
  security_group_id = aws_security_group.SecurityGroup_webServer.id

  # インバウンドルールのタイプを設定
  type = "ingress"

  # インバウンドルールのプロトコルを設定
  protocol = "tcp"

  # インバウンドルールのポート番号を設定
  from_port = 80
  to_port   = 80

  # インバウンドルールのソースを設定
  # CIDR で指定
  # 0.0.0.0/0 は、どの IP アドレスからでも接続を許可するという意味
  cidr_blocks = ["0.0.0.0/0"]
}

# Web サーバー用のセキュリティグループのインバウンドルールを設定 - https
# resource "aws_security_group_rule" "識別名"
resource "aws_security_group_rule" "SecurityGroup_webServer_inbound_https" {

  # 接続するセキュリティグループのIDを設定
  security_group_id = aws_security_group.SecurityGroup_webServer.id

  # インバウンドルールのタイプを設定
  type = "ingress"

  # インバウンドルールのプロトコルを設定
  protocol = "tcp"

  # インバウンドルールのポート番号を設定
  from_port = 443
  to_port   = 443

  # インバウンドルールのソースを設定
  # CIDR で指定
  # 0.0.0.0/0 は、どの IP アドレスからでも接続を許可するという意味
  cidr_blocks = ["0.0.0.0/0"]
}

# Web サーバー用のセキュリティグループのアウトバウンドルールを設定 - tcp3000
# resource "aws_security_group_rule" "識別名"
resource "aws_security_group_rule" "SecurityGroup_webServer_outbound_tcp3000" {

  # 接続するセキュリティグループのIDを設定
  security_group_id = aws_security_group.SecurityGroup_webServer.id

  # アウトバウンドルールのタイプを設定
  type = "egress"

  # アウトバウンドルールのプロトコルを設定
  protocol = "tcp"

  # アウトバウンドルールのポート番号を設定
  from_port = 3000
  to_port   = 3000

  # アウトバウンドルールのソースを設定
  # CIDR で指定
  # 0.0.0.0/0 は、どの IP アドレスからでも接続を許可するという意味
  cidr_blocks = ["0.0.0.0/0"]
}

