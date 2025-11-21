terraform {
  required_version = ">= 1.0.0"

  provider_installation {
    filesystem_mirror {
      path    = "C:/terraform-providers"
      include = ["hashicorp/aws"]
    }
    direct {
      exclude = ["hashicorp/aws"]
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}
