## Go

These settings apply only when `--go` is specified on the command line.

### Fix up regular expressions to support Unicode.

``` yaml 
directive:
  from: swagger-document # do it globally
  where: $.paths..parameters[?(@.name == "resourceGroupName" || @.name == "sourceResourceGroupName")].pattern
  set: ^[-\p{L}\._\(\)\w]+$ 
  reason: Necessary to match Unicode characters in the Go regexp engine.
```

``` yaml $(go) && $(track2) && $(package-resources)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/resources/armresources/v3
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```
