provider "aws" {
  region = var.region
}

module "mysql" {
  source = "../../modules/db"

  instance_name = "media-wiki-db"
  db_name = "my_wiki"

  instance_class = "db.t2.micro"
  storage_size = 20
  db_user = var.dbuser
  db_password = var.dbpassword
  vpc_security_group_id = data.terraform_remote_state.web.outputs.instance_sg_id
}

data "terraform_remote_state" "web" {
  backend = "local"

  config = {
  path = "../web/terraform.tfstate"
  }
}