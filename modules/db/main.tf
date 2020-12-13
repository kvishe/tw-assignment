
resource "aws_db_instance" "media-wiki" {
  engine = "mariadb"
  identifier = var.instance_name
  allocated_storage = var.storage_size
  instance_class = var.instance_class
  name = var.db_name
  username = var.db_user
  password = var.db_password
  skip_final_snapshot = true
  vpc_security_group_ids = [var.vpc_security_group_id]
}
