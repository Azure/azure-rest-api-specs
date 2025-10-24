## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: hardwaresecuritymodules
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/hardwaresecuritymodules/armhardwaresecuritymodules
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
- from: dedicatedhsm.json
  where: $.definitions
  transform: >
    $.SystemData["x-ms-client-name"] = "DedicatedHsmSystemData";
```
