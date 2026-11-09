provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "terraform-aws-lab"
      ManagedBy = "terraform"
    }
  }
}
