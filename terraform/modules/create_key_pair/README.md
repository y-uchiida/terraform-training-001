# create_key_pair モジュール

このモジュールは、EC2 インスタンスなどにアクセスするためのキーペアを作成する。  

作成されたキーペアは、AWS Systems Manager のパラメータストアに保存される。

また、EC2に登録できるように、AWSのキーペアリストにも登録される。

## 利用方法

```hcl
# モジュールの呼び出し
module "sample_key_pair" {
  source   = "./modules/create_key_pair"
  key_name = "sample_key_pair"
  algorithm = "ed25519"
  rsa_bits  = 4096
  key_pair_parameter_store_path = "/sample_key_pair"
}

# EC2 インスタンスに適用する
resource "aws_instance" "sample_instance" {
  ami           = "ami-05a03e6058638183d"
  instance_type = "t2.micro"
  key_name      = module.sample_key_pair.key_name
  tags = {
    Name = "sample_instance"
  }
}

```
