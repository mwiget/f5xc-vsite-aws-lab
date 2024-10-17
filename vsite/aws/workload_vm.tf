resource "aws_instance" "workload_vm" {
  count                       = 1
  ami                         = data.aws_ami.latest-ubuntu.id
  instance_type               = "t3.micro"
  user_data_replace_on_change = true
  security_groups             = [ var.aws_sg_allow_sli_id ]
  subnet_id                   = aws_subnet.sli[count.index].id   # TODO needs fixing for multiple az
  associate_public_ip_address = true
  private_ip                  = var.aws_sli_workload_ip
  availability_zone           = format("%s%s", var.aws_region, var.aws_availability_zone)

  user_data = templatefile("${path.module}/templates/ubuntu_workload.tmpl", {
    ssh_public_key = var.ssh_public_key
  })

  tags = {
    Name    = format("%s-sli-workload", var.f5xc_cluster_name)
    Creator = var.aws_owner_tag
  }

  lifecycle {
    ignore_changes = [
      security_groups,
    ]
  }
}

