
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

```yaml $(tag) == 'package-2021-02-01-preview' && $(terraform)
gosdk-folder: services/preview/databoxedge/mgmt/2021-02-01-preview/databoxedge
```

```yaml $(tag) == 'package-2020-12-01' && $(terraform)
gosdk-folder: services/databoxedge/mgmt/2020-12-01/databoxedge
```

```yaml $(tag) == 'package-2020-09-01-preview' && $(terraform)
gosdk-folder: services/preview/databoxedge/mgmt/2020-09-01-preview/databoxedge

```

```yaml $(tag) == 'package-2020-09-01' && $(terraform)
gosdk-folder: services/databoxedge/mgmt/2020-09-01/databoxedge
```

```yaml $(tag) == 'package-2020-05-preview' && $(terraform)
gosdk-folder: services/preview/databoxedge/mgmt/2020-05-01-preview/databoxedge
```

```yaml $(tag) == 'package-2019-08' && $(terraform)
gosdk-folder: services/databoxedge/mgmt/2019-08-01/databoxedge
```

```yaml $(tag) == 'package-2019-07' && $(terraform)
gosdk-folder: services/databoxedge/mgmt/2019-07-01/databoxedge
```

```yaml $(tag) == 'package-2019-03' && $(terraform)
gosdk-folder: services/databoxedge/mgmt/2019-03-01/databoxedge
```
