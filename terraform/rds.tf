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
