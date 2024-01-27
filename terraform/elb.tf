# ALB(Application Load Balancer) を設定する
resource "aws_lb" "alb" {
  name = "${var.projectName}-${var.environment}-alb"

  # ロードバランサーを内部用にするかどうか
  internal = false

  # ロードバランサーのタイプ
  load_balancer_type = "application"

  # ロードバランサーのセキュリティグループを設定
  security_groups = [
    aws_security_group.SecurityGroup_webServer.id
  ]

  # 利用するサブネットを設定
  subnets = [
    aws_subnet.publicSubnet_1a.id,
    aws_subnet.publicSubnet_1c.id
  ]

  tags = {
    Name        = "${var.projectName}-${var.environment}-alb"
    Environment = "${var.environment}"
  }
}
