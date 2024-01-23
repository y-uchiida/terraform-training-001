# 構築のために用いるが、管理対象として扱わないリソースを定義する
# 具体的にはS3 のプレフィックスリストなど、data ブロックで定義する内容を記載する

# S3 のプレフィックスリストを取得する
# data "aws_prefix_list" "<任意の名前>"
# AWS側であらかじめ定義されているものは、マネージドプレフィックスリストとして利用できる
# AWS コンソールから確認可能
# VPC > マネージドプレフィックスリスト で一覧表示される
data "aws_prefix_list" "s3_prefixList" {
  # マネージドプレフィックスリストの名称を指定
  # name に指定したいプレフィックスリストの名前を指定する
  # * はワイルドカードとして扱われる
  name = "com.amazonaws.*.s3"
}

# App サーバー用の EC2 のマシンイメージを取得する
# data "aws_ami" "<任意の名前>"
data "aws_ami" "appServerAMI" {
  # 最新のバージョンを取得する
  most_recent = true

  # イメージの所有者を指定する
  # 以下の場合は、自分自身とAmazon が所有するイメージが取得される
  owners = ["self", "amazon"]

  # イメージのフィルタを指定する
  # 以下の場合は、Amazon Linux 2 のイメージが取得される
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# 踏み台サーバー用の EC2 のマシンイメージを取得する
# data "aws_ami" "<任意の名前>"
data "aws_ami" "bastionAMI" {
  # 最新のバージョンを取得する
  most_recent = true

  # イメージの所有者を指定する
  # 以下の場合は、自分自身とAmazon が所有するイメージが取得される
  owners = ["self", "amazon"]

  # イメージのフィルタを指定する
  # 以下の場合は、Amazon Linux 2 のイメージが取得される
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}
