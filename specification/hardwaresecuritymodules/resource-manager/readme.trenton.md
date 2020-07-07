
## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: HardwareSecurityModules
    package-name: hardwaresecuritymodules
clear-output-folder: true
output-folder: $(trenton-output-folder)/hardwaresecuritymodule
overrides:
  - where:
      property: /parameters/sku/name
    set:
      - ItemGoTypeName: Name
      - SchemaName: sku_name
  - where:
      property: //sku/name
    set:
      - ItemGoTypeName: "Name"
      - SchemaName: sku_name
  - where:
      property: sku
    set:
      - IsFlatten: true
  - where:
      property: zones
    set:
      - SchemaFunc: azure.SchemaZones()
  - where:
      property: type
    set:
      - Hidden: true
  - where:
      property: /parameters/properties/networkProfile/subnet
    set:
      - IsFlatten: true
  - where:
      property: /parameters/properties/networkProfile/subnet/id
    set:
      - SchemaName: subnet_id
      - Hidden: false
  - where:
      property: //properties/networkProfile/subnet/id
    set:
      - SchemaName: subnet_id
      - Hidden: false
  - where:
      property: statusMessage
    set:
      - Hidden: true
```
