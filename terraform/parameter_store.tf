# RDS インスタンスの接続情報を取得するためのパラメータストアを作成する
# RDSのエンドポイント
resource "aws_ssm_parameter" "rds_endpoint" {
  name  = "/${var.projectName}/${var.environment}/rds/endpoint"
  type  = "String"
  value = aws_db_instance.mySqlStandAlone.endpoint

  tags = {
    Project     = var.projectName
    Environment = var.environment
  }
}

# RDSのポート番号
resource "aws_ssm_parameter" "rds_port" {
  name  = "/${var.projectName}/${var.environment}/rds/port"
  type  = "String"
  value = aws_db_instance.mySqlStandAlone.port

  tags = {
    Project     = var.projectName
    Environment = var.environment
  }
}

# データベース名
resource "aws_ssm_parameter" "rds_db_name" {
  name  = "/${var.projectName}/${var.environment}/rds/db_name"
  type  = "String"
  value = aws_db_instance.mySqlStandAlone.db_name

  tags = {
    Project     = var.projectName
    Environment = var.environment
  }
}

# データベースのユーザー名
resource "aws_ssm_parameter" "rds_username" {
  name  = "/${var.projectName}/${var.environment}/rds/username"
  type  = "SecureString"
  value = aws_db_instance.mySqlStandAlone.username

  tags = {
    Project     = var.projectName
    Environment = var.environment
  }
}

# データベースのパスワード
resource "aws_ssm_parameter" "rds_password" {
  name  = "/${var.projectName}/${var.environment}/rds/password"
  type  = "SecureString"
  value = aws_db_instance.mySqlStandAlone.password

  tags = {
    Project     = var.projectName
    Environment = var.environment
  }
}
