provider "aws" {
  region = var.region
}

module "weserver_cluster" {
  source = "../../modules/web"
    
  image_id  = var.image_id
  cluster_name = "media-wiki-web"
  instance_type = "t2.micro"
  aws_key = var.aws_key
  
  min_size = 1
  max_size = 1
}
