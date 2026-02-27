## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/billingbenefits/armbillingbenefits
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
directive: 
- from: swagger-document
  where: $.parameters.ApiVersionParameter
  transform: >
    $["x-ms-parameter-location"] = "method"; 
- from: swagger-document
  where: $.parameters.ExpandParameter
  transform: >
    $["x-ms-parameter-location"] = "method"; 
```
