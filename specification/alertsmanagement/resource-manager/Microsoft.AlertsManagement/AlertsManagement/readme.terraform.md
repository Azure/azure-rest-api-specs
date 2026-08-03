## overrides

These settings apply only when `--terraform` is specified on the command line.
``` yaml $(terraform)
overrides:
  - where:
      resource: "*"
    set:
      - NeedSeparated: true
      - CombineCreateUpdate: true
  - where:
      resource: "ActionRules"
      property: "properties"
    set:
      - GoFieldName: "Properties"
  - where:
      resource: "ActionRules"
      method: "Update"
      property: "properties"
    set:
      - GoFieldName: "PatchProperties"
  - where:
      property: "status"
    set:
      - Hidden: false
  - where:
      property: "type"
    set:
      - Hidden: true
  - where:
      resource: "ActionRules"
      property: "/actionRule/properties/type"
    set:
      - Hidden: false
  - where:
      resource: "ActionRules"
      property: "scopeType"
    set:
      - EnumValues/0/GoEnumMemberName: "ScopeTypeResourceGroup"
      - EnumValues/1/GoEnumMemberName: "ScopeTypeResource"
      - EnumValues/2/GoEnumMemberName: "ScopeTypeSubscription"
```
## Terraform

These settings apply only when `--terraform` is specified on the command line.

``` yaml $(terraform)
terraform:
    cli-name: alertsManagement
    package-name: alertsmanagement
clear-output-folder: true
output-folder: $(terraform-output-folder)/alertsmanagement
```
``` yaml $(tag) == 'package-2019-06-preview' && $(terraform)
gosdk-folder: services/preview/alertsmanagement/mgmt/2019-06-01-preview/alertsmanagement
```

``` yaml $(tag) == 'package-preview-2019-05' && $(terraform)
gosdk-folder: services/preview/alertsmanagement/mgmt/2019-05-05-preview/alertsmanagement
```

``` yaml $(tag) == 'package-2019-03' && $(terraform)
gosdk-folder: services/alertsmanagement/mgmt/2019-03-01/alertsmanagement
```

``` yaml $(tag) == 'package-2018-05' && $(terraform)
gosdk-folder: services/alertsmanagement/mgmt/2018-05-05/alertsmanagement
```

``` yaml $(tag) == 'package-2018-05-preview' && $(terraform)
gosdk-folder: services/preview/alertsmanagement/mgmt/2018-05-05-preview/alertsmanagement
```
