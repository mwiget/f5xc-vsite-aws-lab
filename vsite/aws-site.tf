module "aws-node" {
  count                     = length(var.aws_slo_subnets)
  source                    = "./aws"
  f5xc_cluster_name         = format("%s%s",var.f5xc_vsite_name, element(var.aws_availability_zones, count.index))

  ssh_public_key            = var.ssh_public_key

  aws_region                = var.aws_region
  aws_availability_zone     = element(var.aws_availability_zones, count.index)
  aws_instance_type         = var.aws_instance_type
  aws_ami_name              = var.aws_ami_name

  aws_vpc_name              = format("%s-vpc", var.f5xc_vsite_name)
  aws_vpc_cidr              = var.aws_vpc_cidr
  aws_owner_tag             = var.aws_owner_tag

  aws_slo_subnet            = var.aws_slo_subnets[count.index]
  aws_sli_subnet            = var.aws_sli_subnets[count.index]
  aws_sli_workload_ip       = var.aws_sli_workload_ip[count.index]
}
