# What did you deploy?

Deployed a VM with a NIC assigned with a public IP address. Associated an NSG to the subnet and was able to SSH into the running VM.

# What worked?

`terraform destroy` deleted all the infrastructure defined in `main.tf`. This is useful as it automates the process of tearing down infrastructure when not needed. This was needed as I had an error where I wanted to create a subnet resource, but there was already one existing. 

# What did you struggle with, and how did you solve it?

### Subnet already exists
```
│ Error: Invalid index
│ 
│   on main.tf line 34, in resource "azurerm_network_interface" "nic":
│   34:     subnet_id                     = azurerm_virtual_network.vnet.subnet[0].id
│ 
│ Elements of a set are identified only by their value and don't have any separate index or key to select with, so it's only possible to perform operations across all
│ elements of the set.
```

Created a separate subnet resource rather than an in-line subnet in the Vnet resource.

```
╷
│ Error: a resource with the ID "/subscriptions/9754a204-3048-4025-9291-cd471afdddb0/resourceGroups/rg-terraform-vm/providers/Microsoft.Network/virtualNetworks/vnet-terraform-vm/subnets/subnet-terraform-vm" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_subnet" for more information
│ 
│   with azurerm_subnet.subnet,
│   on main.tf line 39, in resource "azurerm_subnet" "subnet":
│   39: resource "azurerm_subnet" "subnet" {
│ 
╵
```

After applying that change and doing `terraform validate`, I had this error where Terraform could not create a subnet resource as one already exists. To fix this, I did `terraform destory` which automatically deletes all the infrastructure I created. I initially tried `terraform state list` and combine it with `terraform destory -target` but it did not show the subnet resource.


### SSH public key missing 
```
╷
│ Error: Invalid function argument
│ 
│   on main.tf line 79, in resource "azurerm_linux_virtual_machine" "vm":
│   79:     public_key = file("~/.ssh/id_rsa.pub")
│     ├────────────────
│     │ while calling file(path)
│ 
│ Invalid value for "path" parameter: no file exists at "~/.ssh/id_rsa.pub"; this function works only with files that are distributed as part of the configuration
│ source code, so if this file will be created by a resource in this configuration you must instead obtain this result from an attribute of that resource.
╵
```

When trying to create a VM with Terraform, I initially got this error. I initially had an assumption that this would place a public key in the VM, but after reading the docs the file() function reads and copies the public key in my local machine to the remote VM. However, I did not have a public key yet, so I had to create one first. 

`ssh-keygen -m PEM -t rsa -b 4096`

SSH works by having a private and public key. The public key can be shared with anyone, while the private key remains 'private'. The remote VM ensures that the client has the correct private key via the public key before allowing them to connect.




