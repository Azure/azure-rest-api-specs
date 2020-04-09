## Trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
  cli_name: WindowsIot
  azure_arm: true
  license_header: MICROSOFT_MIT_NO_VERSION
  payload_flattening_threshold: 2
  namespace: azure.mgmt.windowsiot
  package_name: azure-mgmt-windowsiot
  clear_output_folder: false
overrides:
  - where:
      method: "Update"
    set:
      - BodyPosition: 2
  - where:
      method: "CreateOrUpdate"
    set:
      - BodyPosition: 2
  - where:
      property: "deviceName"
    set:
      - IdPortion: "DeviceServices"
```