terraform {
  backend "s3" {
    bucket       = "emiliia-terraform-state-lesson-5"
    key          = "global/s3/terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
}