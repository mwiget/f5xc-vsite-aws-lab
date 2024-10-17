#!/bin/bash
ip=`jq -r '.outputs.ip_address.value[] | select(."mw-aws-vsite-1a-sli-workload") | ."mw-aws-vsite-1a-sli-workload"' terraform.tfstate`
echo "ssh ubuntu@$ip ..."
ssh -i ./workload_ssh_key -o "StrictHostKeyChecking=no" ubuntu@$ip
