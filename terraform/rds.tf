# パラメータグループの設定
resource "aws_db_parameter_group" "mySqlStandAloneParameterGroup" {
  name        = "${var.projectName}-${var.environment}-mysql-standalone-parameter-group"
  family      = "mysql8.0"
  description = "mySqlStandAloneParameterGroup"

  # 文字コード設定をutf8mb4に変更
  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}

# オプショングループの設定
resource "aws_db_option_group" "mySqlStandAloneOptionGroup" {
  name                     = "${var.projectName}-${var.environment}-mysql-standalone-option-group"
  engine_name              = "mysql"
  major_engine_version     = "8.0"
  option_group_description = "mySqlStandAloneOptionGroup"
}

# サブネットグループの設定
# 作成済みのプライベートサブネットを束ねる
resource "aws_db_subnet_group" "mySqlStandAloneSubnetGroup" {
  name = "${var.projectName}-${var.environment}-mysql-standalone-subnet-group"
  subnet_ids = [
    aws_subnet.privateSubnet_1a.id,
    aws_subnet.privateSubnet_1c.id
  ]

  tags = {
    Name    = "${var.projectName}-${var.environment}-mysql-standalone-subnet-group"
    Project = var.projectName
    Env     = var.environment
  }
}

# パスワードとして利用するためのランダム文字列生成
# 長さは16文字、特殊文字は含めない
resource "random_string" "dbPassword" {
  length  = 16
  special = false
}

# RDSの設定
# インスタンスタイプはt3.micro
# ストレージタイプはgp2
# ストレージ容量は20GBで、最大50GBまで自動拡張
# マルチAZは利用しない
# アベイラビリティゾーンはap-northeast-1aとap-northeast-1aを利用
resource "aws_db_instance" "mySqlStandAlone" {
  engine         = "mysql"
  engine_version = "8.0"
  port           = 3306
  identifier     = "${var.projectName}-${var.environment}-mysql-standalone"

  username = "admin"
  password = random_string.dbPassword.result

  # DB名はプロジェクト名と環境名を組み合わせて作成
  # ハイフンが利用できないため、アンダースコアを利用する
  db_name = "${var.projectName}_${var.environment}"

  instance_class = "db.t3.micro"

  storage_type          = "gp2"
  allocated_storage     = 20
  max_allocated_storage = 50
  storage_encrypted     = false

  # マルチAZは利用しない
  # アベイラビリティゾーンはap-northeast-1aとap-northeast-1aを利用
  multi_az             = false
  availability_zone    = "ap-northeast-1a"
  db_subnet_group_name = aws_db_subnet_group.mySqlStandAloneSubnetGroup.name

  # 割当するセキュリティグループを設定
  vpc_security_group_ids = [
    aws_security_group.SecurityGroup_databaseServer.id
  ]
  # 外部アクセスを拒否する(インターネットからの直接接続ができない)
  publicly_accessible = false

  # パラメータグループとオプショングループを設定する
  parameter_group_name = aws_db_parameter_group.mySqlStandAloneParameterGroup.name
  option_group_name    = aws_db_option_group.mySqlStandAloneOptionGroup.name

  # バックアップ設定
  # バックアップ実施時刻は 4:00-5:00 AM
  # バックアップ保持期間は 7日間
  backup_window           = "04:00-05:00"
  backup_retention_period = 7

  # メンテナンスウィンドウは 月曜日 5:00-7:00 AM
  # この時間中は、RDSインスタンスが停止する可能性がある
  # RDSのマイナーバージョンアップは自動で実施する
  maintenance_window         = "mon:05:00-mon:07:00"
  auto_minor_version_upgrade = true
  apply_immediately          = true

  # 削除保護を無効化
  # 本番環境など、誤って削除しないようにする場合はtrueにする
  deletion_protection = false

  # 最終スナップショットを作成しない
  # 本番環境など、復旧が行えるようにする必要がある場合はfalseにする
  skip_final_snapshot = true

  # タグを設定
  tags = {
    Name    = "${var.projectName}-${var.environment}-mysql-standalone"
    Project = var.projectName
    Env     = var.environment
  }
}
