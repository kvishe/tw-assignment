
resource "aws_launch_configuration" "media-wiki" {
  image_id = var.image_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.instance.id]
  user_data = file("${path.module}/user-data.sh")
  key_name = var.aws_key

  lifecycle{
    create_before_destroy = true 
  }
}

resource "aws_security_group" "instance" {
  name = "${var.cluster_name}-instance"

  lifecycle{
    create_before_destroy = true 
  }
}

resource "aws_security_group_rule" "allow_service_port_inbound" {
  type = "ingress"
  security_group_id = aws_security_group.instance.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_service_dbport_inbound" {
  type = "ingress"
  security_group_id = aws_security_group.instance.id
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  self              = true
}

resource "aws_security_group_rule" "allow_service_port_outbound" {
  type = "egress"
  security_group_id = aws_security_group.instance.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_autoscaling_group" "media-wiki" {
  launch_configuration = aws_launch_configuration.media-wiki.id
  availability_zones = data.aws_availability_zones.all.names
  
  load_balancers = [aws_elb.media-wiki.name]
  health_check_type = "ELB"

  min_size = var.min_size
  max_size = var.max_size
  tag {
    key = "Name"
    value = var.cluster_name
    propagate_at_launch = true
  }
  
}

resource "aws_elb" "media-wiki" {
  name = "${var.cluster_name}-elb"
  availability_zones = data.aws_availability_zones.all.names
  security_groups = [aws_security_group.elb.id]
  
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = 80
    instance_protocol = "http"
    }

    health_check {
      healthy_threshold = 3
      unhealthy_threshold = 3
      timeout = 3
      interval = 30
      target = "HTTP:80/"
    }
}

resource "aws_security_group" "elb" {
  name = "${var.cluster_name}-elb"
}

resource "aws_security_group_rule" "allow_http_inbond" {
  type = "ingress"
  security_group_id = aws_security_group.elb.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_outbond" {
  type = "egress"
  security_group_id = aws_security_group.elb.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

data "aws_availability_zones" "all" {}
