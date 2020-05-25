# vault-demo-raft
Hashicorp Vault demo with raft backend

For personnal test & dev, this repo permit to build 3 vagrant VM

## Install Vault role

I currently use https://github.com/nehrman/ansible-vault rather than https://github.com/ansible-community/ansible-vault/ in order to have the Raft feature
```
ansible-galaxy install -r requirements.yml --force
```

To create the 3 servers (with vagrant) and install Vault (with ansible), you just need to run :
```
vagrant up
```

