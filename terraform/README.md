

# Create your variables.tf

```
variable region {
  type    = string
  default = "eu-west-1"
}
	
variable myname {
  type    = string
  default = "vault-demo-raft"
}
		
variable mycidr {
  type    = list
  default = ["YOUR_PUBLIC_IP/32"]
}
```

# build the infra
terraform init
terraform plan
terraform apply

eval $(ssh-agent)

terraform output ssh_key | ssh-agent -

# check the ansible group tag_Stack_vault_demo_raft
ansible-inventory -i inventory.aws_ec2.yml --graph

# run the playbook
ansible-playbook site.yml -i inventory.aws_ec2.yml


