# Terraform におけるモジュール

## モジュールとは

Terraformでは、モジュールは再利用可能なTerraformコードの単位で、一連のTerraformリソースを含むことができる

モジュールは他のTerraform設定から呼び出すことができ、入力変数と出力を定義することができる

## モジュールの単位

モジュールはディレクトリ単位で定義される

つまり、`terraform` ディレクトリに `main.tf`と`data.tf`がある場合、これらのファイルはまとめてひとつのモジュールとして扱われる

このモジュールは、そのディレクトリのパスを指定することで他のTerraform設定から呼び出すことができる

たとえば、 `terraform` ディレクトリのパスが `./terraform` である場合、以下のように呼び出すことができる

```terraform
module "terraform" {
  source = "./terraform"

  # モジュールの入力変数を設定（必要に応じて）
}
```

## モジュールの入力変数

モジュールの入力変数は、モジュールの呼び出し元から渡される値である

モジュールの入力変数は、モジュールのディレクトリに`variable` ブロックを定義することで定義できる

たとえば、以下のように定義することで、 `name` と `environment` の2つの入力変数を定義できる

```terraform
variable "name" {
  type = string
}

variable "environment" {
  type = string
}
```

ただし、各ファイルでそれぞれ `variable` ブロックを定義すると見通しが悪くなってしまうので、`variables.tf` というファイルを作成し、そこにまとめて定義することが推奨されている

`variables.tf` と同一のディレクトリにある tf ファイルは、 `variables.tf` で設定した変数を共通して利用できる

## モジュールの出力

モジュールの出力は、モジュールの呼び出し元に返される値である

モジュールの出力は、モジュールのディレクトリに `output` ブロックを定義することで定義できる

たとえば、以下のように定義することで、 `name` と `environment` の2つの出力を定義できる

```terraform
output "name" {
  value = var.name
}

output "environment" {
  value = var.environment
}
```

ただし、各ファイルでそれぞれ `output` ブロックを定義すると見通しが悪くなってしまうので、`outputs.tf` というファイルを作成し、そこにまとめて定義する
