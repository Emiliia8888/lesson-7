terraform {
  backend "s3" {
    bucket       = "emiliia-terraform-state-lesson-5"
    key          = "global/s3/terraform.tfstate"
    region       = "us-west-2"
    encrypt      = true
    use_lockfile = true
  }
}