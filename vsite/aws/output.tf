output "nodes" {
  value = {
    master  = aws_instance.master_vm
  }
}

output "ip_address" {
    value = {
    for node in range(length(aws_instance.master_vm)):
      aws_instance.master_vm[node].tags.Name => aws_eip.sm_pub_ips[node].public_ip
  }
}

output "workload_ip_address" {
    value = {
    for node in range(length(aws_instance.workload_vm)):
      aws_instance.workload_vm[node].tags.Name => aws_instance.workload_vm[node].public_ip
  }
}
