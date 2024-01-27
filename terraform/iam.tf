# AMポリシードキュメントは、AWSリソースに対するアクセス許可を定義する
# この場合は、EC2インスタンスが自身のIAMロールを引き受けることを許可する
# この設定により、EC2インスタンスはIAMロールに関連付けられたポリシーに定義されたアクションを実行できる
# これにより、EC2インスタンスがAWSリソースに対して必要な操作を行うための適切な権限を持つことができる
data "aws_iam_policy_document" "ec2" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

  }
}

# App サーバーに設定する IAM Role の作成
resource "aws_iam_role" "app_iam_role" {
  name               = "${var.projectName}-${var.environment}-app-iam-role"
  assume_role_policy = data.aws_iam_policy_document.ec2.json
}

# App サーバーに設定する IAM Role に EC2ReadOnly ポリシーをアタッチ
# EC2ReadOnly ポリシーは、EC2 インスタンスの情報を読み取るために必要
resource "aws_iam_role_policy_attachment" "app_iam_role_ec2_readonly" {
  role       = aws_iam_role.app_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

# App サーバーに設定する IAM Role に AmazonSSMManagedInstanceCore ポリシーをアタッチ
# AmazonSSMManagedInstanceCore ポリシーは、SSM エージェントをインストールするために必要
resource "aws_iam_role_policy_attachment" "app_iam_role_ssm" {
  role       = aws_iam_role.app_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# App サーバーに設定する IAM Role に AmazonSSMReadOnlyAccess ポリシーをアタッチ
# AmazonSSMReadOnlyAccess ポリシーは、SSM エージェントをインストールするために必要
resource "aws_iam_role_policy_attachment" "app_iam_role_ssm_readonly" {
  role       = aws_iam_role.app_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

# App サーバーに設定する IAM Role に AmazonS3ReadOnlyAccess ポリシーをアタッチ
# AmazonS3ReadOnlyAccess ポリシーは、S3 バケットからファイルをダウンロードするために必要
resource "aws_iam_role_policy_attachment" "app_iam_role_s3_readonly" {
  role       = aws_iam_role.app_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# インスタンスプロフィールを作成して、EC2インスタンスにロールをアタッチできるようにする
resource "aws_iam_instance_profile" "app_iam_instance_profile" {
  name = aws_iam_role.app_iam_role.name
  role = aws_iam_role.app_iam_role.name
}
