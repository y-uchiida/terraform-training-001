# Get Started

Terraform を使って、AWS にインフラをデプロイするための手順を簡易にまとめます。

## セットアップ

1. tfenv をインストールする
2. tfevn で Terraform をインストールする(1.7.0 以上)
3. [AWS CLI](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-chap-install.html) をインストールする
4. [AWS CLI](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-chap-configure.html) を設定する
5. TFLint をインストールする
6. このリポジトリをクローンする
7. `terraform/terraform.tfvars.example` を `terraform/terraform.tfvars` にリネームし、設定値を書き換える
8. `terraform -chdir=terraform init` を実行する(もしくは、terraform ディレクトリに移動して `terraform init` を実行する)

## デプロイ

1. `terraform -chdir=terraform plan` を実行する(もしくは、terraform ディレクトリに移動して `terraform plan` を実行する)
2. 表示される内容を確認する
3. `terraform -chdir=terraform apply` を実行する(もしくは、terraform ディレクトリに移動して `terraform apply` を実行する)
