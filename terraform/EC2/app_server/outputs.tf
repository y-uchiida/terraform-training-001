# モジュールから取得できる値(引数)を定義する

# 生成したEC2インスタンスのID
output "app_server_id" {
  value = aws_instance.app_server.id
}
