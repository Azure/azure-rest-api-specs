## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
directive:
  - from: virtualMachineScaleSet.json
    where: $.definitions.VirtualMachineScaleSetVMProperties.properties
    transform: >
      $['timeCreated'] = {
          "readOnly": true,
          "type": "string",
          "format": "date-time",
          "description": "Specifies the time at which the Virtual Machine resource was created."
        }
```