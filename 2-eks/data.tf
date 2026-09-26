data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "gowtham-infra-statefile-backup"
    key    = "gowtham/1-network/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
