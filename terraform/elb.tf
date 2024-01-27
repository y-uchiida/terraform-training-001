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
    project     = "${var.projectName}"
    Environment = "${var.environment}"
  }
}

# ALB に紐づくリスナーを設定する
# リスナーはロードバランサーに対してリクエストを受け付けるポートを設定する
# ここでは80番ポートでHTTPリクエストを受け付けるように設定している
resource "aws_lb_listener" "listener_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targetGroup.arn
  }
}

# ALB に紐づくターゲットグループを設定する
# ターゲットグループにEC2インスタンスなどのリソースを登録することで、
# ロードバランシングの対象とすることができる
resource "aws_lb_target_group" "targetGroup" {
  name     = "${var.projectName}-${var.environment}-app-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  tags = {
    Name        = "${var.projectName}-${var.environment}-app-tg"
    project     = "${var.projectName}"
    Environment = "${var.environment}"
  }
}

# ターゲットグループに紐づくリソースを設定する
# ここではEC2インスタンスをターゲットとして登録する
resource "aws_lb_target_group_attachment" "targetGroupAttachment" {
  target_group_arn = aws_lb_target_group.targetGroup.arn
  target_id        = module.app_server.app_server_id
  port             = 3000
}
