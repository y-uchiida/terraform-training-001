# Route53 の設定を行う
resource "aws_route53_zone" "route53_zone" {
  name = var.domainName

  # 削除時の挙動を設定
  # true に設定すると、Terraform で管理していないDNSレコードがあった場合も削除される
  force_destroy = false

  tags = {
    Name        = "${var.projectName}-${var.environment}-route53-zone"
    Project     = var.projectName
    Environment = var.environment
  }
}

# 設定するドメイン名のAレコードを設定
resource "aws_route53_record" "route53_record" {
  zone_id = aws_route53_zone.route53_zone.zone_id
  name    = "dev-alb.${var.domainName}"
  type    = "A"

  # 名前解決先のELB の DNS 名を設定
  alias {
    name    = aws_lb.alb.dns_name
    zone_id = aws_lb.alb.zone_id
    # ELB のヘルスチェックを有効にする
    evaluate_target_health = true
  }

  # allow_orverwrite を true に設定すると、
  # 既存のレコードを上書きする
  allow_overwrite = true
}
