
## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: hardwaresecuritymodules
    package-name: hardwaresecuritymodules
clear-output-folder: true
output-folder: $(trenton-output-folder)/hardwaresecuritymodules
overrides:
  - where:
      property: /parameters/sku/name
    set:
      - ItemGoTypeName: Name
  - where:
      property: /parameters/properties/networkProfile/subnet/id
    set:
      - Hidden: false
```
