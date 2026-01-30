## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/recoveryservices/armrecoveryservicessiterecovery/v2
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive: 
- from: swagger-document
  where: $.parameters.ResourceGroupName
  transform: >
    $["x-ms-parameter-location"] = "method"; 
- from: swagger-document
  where: $.parameters.ResourceName
  transform: >
    $["x-ms-parameter-location"] = "method";
```
