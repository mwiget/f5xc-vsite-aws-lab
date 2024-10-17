output "vsite1" {
  value = module.vsite1
  sensitive = true
}

output "vsite2" {
  value = module.vsite2
  sensitive = true
}

output "ip_address" {
  value = flatten(concat(
    module.vsite1[*].node.aws[*].ip_address,
    module.vsite2[*].node.aws[*].ip_address,
    module.vsite1[*].node.aws[*].workload_ip_address,
    module.vsite2[*].node.aws[*].workload_ip_address
  ))
}

