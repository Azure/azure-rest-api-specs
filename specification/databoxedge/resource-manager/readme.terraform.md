
## Terraform

These settings apply only when `--terraform` is specified on the command line.

``` yaml $(terraform)
terraform:
    cli-name: databoxedge
    package-name: databoxedge
clear-output-folder: true
output-folder: $(terraform-output-folder)/databoxedge
```
## overrides

These settings apply only when `--terraform` is specified on the command line.
``` yaml $(terraform)
overrides:
  - where:
      resource: "BandwidthSchedules"
      method: "CreateOrUpdate"
    set:
      - BodyPosition: 2
  - where:
      resource: "Containers"
      method: "CreateOrUpdate"
    set:
      - BodyPosition: 3
  - where:
      resource: "Devices"
      method: "CreateOrUpdate"
    set:
      - BodyPosition: 1
  - where:
      resource: "Devices"
      method: "Update"
    set:
      - BodyPosition: 1
  - where:
      resource: "Orders"
      method: "CreateOrUpdate"
    set:
      - BodyPosition: 1
  - where:
      resource: "Roles"
      method: "CreateOrUpdate"
    set:
      - BodyPosition: 2
  - where:
      resource: "Shares"
      method: "CreateOrUpdate"
    set:
      - BodyPosition: 2
  - where:
      resource: "StorageAccountCredentials"
      method: "CreateOrUpdate"
    set:
      - BodyPosition: 2
  - where:
      resource: "StorageAccounts"
      method: "CreateOrUpdate"
    set:
      - BodyPosition: 2
  - where:
      resource: "Triggers"
      method: "CreateOrUpdate"
    set:
      - BodyPosition: 2
  - where:
      resource: "Users"
      method: "CreateOrUpdate"
    set:
      - BodyPosition: 2
  - where:
      property: "SSLStatus"
    set:
      - GoFieldName: "SslStatus"
```