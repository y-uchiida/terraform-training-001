# ドメイン証明書の設定
# ap-northeast-1(tokyo)リージョン用の証明書を発行する
resource "aws_acm_certificate" "ap-northeast-1_certificate" {
  domain_name = "*.${var.domainName}"

  # DNS レコードによって検証を行うように設定
  validation_method = "DNS"

  tags = {
    Name        = "${var.projectName}-${var.environment}-wildcard-ssl-cert"
    Project     = var.projectName
    Environment = var.environment
  }

  lifecycle {
    # ELB で証明書を利用する場合、create_before_destroy を true にしておくことを推奨
    # この設定により、削除前に新しい証明書が作成されるようになる
    create_before_destroy = true
  }

  # Route53 のゾーンに依存するので、依存関係を明示しておく
  depends_on = [
    aws_route53_zone.route53_zone,
  ]
}
