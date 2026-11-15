# What did you deploy?

Deployed a resource group to Azure using Terraform

# What worked?

`terraform init` successfully downloaded the Azure provider.

`terraform plan` correctly identified the resource to be created.

```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.resource_group will be created
  + resource "azurerm_resource_group" "resource_group" {
      + id       = (known after apply)
      + location = "newzealandnorth"
      + name     = "rg-terraform-vm"
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

`terraform apply` completed successfully.

`terraform fmt` and `terraform validate` was also used to format the .tf files and validate that the syntax was correct.

Confirmed the Resource Group appeared in Azure Portal.

# What did you struggle with, and how did you solve it?

No significant issues encountered.