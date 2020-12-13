provider "aws" {
  region = var.region
}

resource "aws_ami_from_instance" "media-wiki-image" {
  name               = "media-wiki-image"
  source_instance_id = element(tolist(data.terraform_remote_state.web.outputs.instance_id), 0)
  }

data "terraform_remote_state" "web" {
  backend = "local"

  config = {
  path = "../terraform.tfstate"
  }
}