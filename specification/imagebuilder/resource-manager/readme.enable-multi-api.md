# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml
input-file:
  - $(this-folder)/Microsoft.VirtualMachineImages/preview/2019-05-01-preview/imagebuilder.json
  - $(this-folder)/Microsoft.VirtualMachineImages/preview/2018-02-01-preview/imagebuilder.json
  - $(this-folder)/Microsoft.VirtualMachineImages/preview/2019-02-01-preview/imagebuilder.json
require: $(this-folder)/../../../profiles/readme.md
```
