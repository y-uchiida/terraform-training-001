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
