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

# ap-northeast-1(tokyo)リージョン用の証明書を検証するためのレコードを設定
resource "aws_route53_record" "ap-northeast-1_certificate_validation" {
  # domain_validation_options に設定したドメイン名のレコードを設定
  # for_each を利用して、複数のレコードを設定する
  for_each = {
    for dvo in aws_acm_certificate.ap-northeast-1_certificate.domain_validation_options :
    dvo.domain_name => {
      name    = dvo.resource_record_name
      type    = dvo.resource_record_type
      records = [dvo.resource_record_value]
    }
  }

  zone_id = aws_route53_zone.route53_zone.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 600
  records = each.value.records

  # allow_orverwrite を true に設定すると、
  # 既存のレコードを上書きする
  allow_overwrite = true
}

# 証明書の検証を行う
resource "aws_acm_certificate_validation" "ap-northeast-1_certificate_validation" {
  certificate_arn         = aws_acm_certificate.ap-northeast-1_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.ap-northeast-1_certificate_validation : record.fqdn]
}
