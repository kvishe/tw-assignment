output "instance_id" {
  value = module.weserver_cluster.instance_id
}

output "instance_sg_id" {
  value = module.weserver_cluster.instance_sg_id
}

output "elb_dns_name" {
  value = module.weserver_cluster.elb_dns_name
}