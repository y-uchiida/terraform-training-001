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
  # app サーバー用のセキュリティグループからの接続を許可
  source_security_group_id = aws_security_group.SecurityGroup_appServer.id
}

# app サーバー用のセキュリティグループ
# resource "aws_security_group" "識別名"
resource "aws_security_group" "SecurityGroup_appServer" {

  # セキュリティグループの名前を設定
  name = "${var.projectName}-${var.environment}-SecurityGroup_appServer"

  # セキュリティグループの説明を設定
  description = "security group for app servers"

  # VPC の ID を設定
  vpc_id = aws_vpc.vpc.id

  # セキュリティグループのタグを設定
  tags = {
    Name    = "${var.projectName}-${var.environment}-SecurityGroup_appServer"
    Project = var.projectName
    Env     = var.environment
  }
}

# 運用管理用のセキュリティグループ
# resource "aws_security_group" "識別名"
resource "aws_security_group" "SecurityGroup_operationManagement" {

  # セキュリティグループの名前を設定
  name = "${var.projectName}-${var.environment}-SecurityGroup_operationManagement"

  # セキュリティグループの説明を設定
  description = "security group for operationManagement"

  # VPC の ID を設定
  vpc_id = aws_vpc.vpc.id

  # セキュリティグループのタグを設定
  tags = {
    Name    = "${var.projectName}-${var.environment}-SecurityGroup_operationManagement"
    Project = var.projectName
    Env     = var.environment
  }
}

# 運用管理用のセキュリティグループのインバウンドルールを設定 - ssh
# resource "aws_security_group_rule" "識別名"
resource "aws_security_group_rule" "SecurityGroup_operationManagement_inbound_ssh" {

  # 接続するセキュリティグループのIDを設定
  security_group_id = aws_security_group.SecurityGroup_operationManagement.id

  # インバウンドルールのタイプを設定
  type = "ingress"

  # インバウンドルールのプロトコルを設定
  protocol = "tcp"

  # インバウンドルールのポート番号を設定
  from_port = 22
  to_port   = 22

  # インバウンドルールのソースを設定
  # CIDR で指定
  cidr_blocks = ["0.0.0.0/0"]
}

# 運用管理用のセキュリティグループのインバウンドルールを設定 - tcp3000
# resource "aws_security_group_rule" "識別名"
resource "aws_security_group_rule" "SecurityGroup_operationManagement_inbound_tcp3000" {

  # 接続するセキュリティグループのIDを設定
  security_group_id = aws_security_group.SecurityGroup_operationManagement.id

  # インバウンドルールのタイプを設定
  type = "ingress"

  # インバウンドルールのプロトコルを設定
  protocol = "tcp"

  # インバウンドルールのポート番号を設定
  from_port = 3000
  to_port   = 3000

  # インバウンドルールのソースを設定
  # CIDR で指定
  cidr_blocks = ["0.0.0.0/0"]
}


# 運用管理用のセキュリティグループのアウトバウンドルールを設定 - http
# resource "aws_security_group_rule" "識別名"
resource "aws_security_group_rule" "SecurityGroup_operationManagement_outbound_http" {

  # 接続するセキュリティグループのIDを設定
  security_group_id = aws_security_group.SecurityGroup_operationManagement.id

  # アウトバウンドルールのタイプを設定
  type = "egress"

  # アウトバウンドルールのプロトコルを設定
  protocol = "tcp"

  # アウトバウンドルールのポート番号を設定
  from_port = 80
  to_port   = 80

  # アウトバウンドルールのソースを設定
  # CIDR で指定
  cidr_blocks = ["0.0.0.0/0"]
}

# 運用管理用のセキュリティグループのアウトバウンドルールを設定 - https
# resource "aws_security_group_rule" "識別名"
resource "aws_security_group_rule" "SecurityGroup_operationManagement_outbound_https" {

  # 接続するセキュリティグループのIDを設定
  security_group_id = aws_security_group.SecurityGroup_operationManagement.id

  # アウトバウンドルールのタイプを設定
  type = "egress"

  # アウトバウンドルールのプロトコルを設定
  protocol = "tcp"

  # アウトバウンドルールのポート番号を設定
  from_port = 443
  to_port   = 443

  # アウトバウンドルールのソースを設定
  # CIDR で指定
  cidr_blocks = ["0.0.0.0/0"]
}

# データベースサーバー用のセキュリティグループ
# resource "aws_security_group" "識別名"
resource "aws_security_group" "SecurityGroup_databaseServer" {

  # セキュリティグループの名前を設定
  name = "${var.projectName}-${var.environment}-SecurityGroup_databaseServer"

  # セキュリティグループの説明を設定
  description = "security group for database servers"

  # VPC の ID を設定
  vpc_id = aws_vpc.vpc.id

  # セキュリティグループのタグを設定
  tags = {
    Name    = "${var.projectName}-${var.environment}-SecurityGroup_databaseServer"
    Project = var.projectName
    Env     = var.environment
  }
}

# データベースサーバー用のセキュリティグループのインバウンドルールを設定 - mysql/tcp3306
# resource "aws_security_group_rule" "識別名"
resource "aws_security_group_rule" "SecurityGroup_databaseServer_inbound_mysql_tcp3306" {

  # 接続するセキュリティグループのIDを設定
  security_group_id = aws_security_group.SecurityGroup_databaseServer.id

  # インバウンドルールのタイプを設定
  type = "ingress"

  # インバウンドルールのプロトコルを設定
  protocol = "tcp"

  # インバウンドルールのポート番号を設定
  from_port = 3306
  to_port   = 3306

  # インバウンドルールのソースを設定
  # app サーバー用のセキュリティグループからの接続を許可
  source_security_group_id = aws_security_group.SecurityGroup_appServer.id
}
