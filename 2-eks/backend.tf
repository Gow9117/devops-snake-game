terraform {
  backend "s3" {
    bucket         = "gowtham-infra-statefile-backup"
    key            = "gowtham/2-eks/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "gowtham-terraform-locks"
    encrypt        = true
  }
}
