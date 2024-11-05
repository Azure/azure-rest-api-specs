## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/saas/armsaas
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
  from: saas.json
  where: $.paths["/providers/Microsoft.SaaS/saasresources/{resourceId}/listAccessToken"].post
  transform: >
    $["operationId"] = "SaasResources_listAccessToken"
```
