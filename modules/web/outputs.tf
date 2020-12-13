output "elb_dns_name" {
  value = aws_elb.media-wiki.dns_name
}

output "asg_name" {
  value = aws_autoscaling_group.media-wiki.name
}

output "instance_sg_id" {
  value = aws_security_group.instance.id
}

output "instance_id"{
  value = aws_elb.media-wiki.instances
}
