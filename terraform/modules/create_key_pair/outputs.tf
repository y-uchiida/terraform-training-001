output "private_key_pem" {
  value = tls_private_key.keygen.private_key_pem
}

output "public_key_pem" {
  value = tls_private_key.keygen.public_key_openssh
}

output "key_name" {
  value = var.key_name
}

output "key_pair_parameter_store_path" {
  value = var.key_pair_parameter_store_path
}

output "key_pair_parameter_store_path_private_key" {
  value = aws_ssm_parameter.private_key.name
}

output "key_pair_parameter_store_path_public_key" {
  value = aws_ssm_parameter.public_key.name
}
