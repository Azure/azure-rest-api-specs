## overrides

These settings apply only when `--trenton` is specified on the command line.
``` yaml $(trenton)
overrides:
  - where:
      resource: "*"
    set:
<<<<<<< HEAD
      - NeedSeparated: true
=======
      - NeedSeparated: false
>>>>>>> 4ea1e0abb0265a95f3f49494d2f0815b6be6d7d6
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
<<<<<<< HEAD
      property: "status"
    set:
      - Hidden: false
  - where:
=======
>>>>>>> 4ea1e0abb0265a95f3f49494d2f0815b6be6d7d6
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
<<<<<<< HEAD
      - EnumValues/2/GoEnumMemberName: "ScopeTypeSubscription"
=======
>>>>>>> 4ea1e0abb0265a95f3f49494d2f0815b6be6d7d6
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
