terraform {
  backend "s3" {
    bucket         = "emiliia-terraform-state-lesson-5" # Змініть на назву ВАШОГО S3 бакету з Теми 5
    key            = "lesson-7/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock-table"
  }
}