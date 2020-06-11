## overrides

These settings apply only when `--trenton` is specified on the command line.
``` yaml $(trenton)
overrides:
  - where:
      resource: "*"
    set:
      - NeedSeparated: true
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
## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: alertsManagement
    package-name: alertsmanagement
clear-output-folder: true
output-folder: $(trenton-output-folder)/alertsmanagement
```
