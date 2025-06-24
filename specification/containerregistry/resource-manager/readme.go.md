## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/containerregistry/armcontainerregistry
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
  - from: containerregistry_build.json
    where: $.definitions.IdentityProperties.properties
    transform: >
      $.principalId['readOnly'] = true;
      $.tenantId['readOnly'] = true;
  - from: containerregistry_build.json
    where: $.definitions.UserIdentityProperties.properties
    transform: >
      $.principalId['readOnly'] = true;
      $.clientId['readOnly'] = true;
  - from: containerregistry_build.json
    where: $.definitions.ErrorResponse
    transform: >
      $['x-ms-client-name'] = 'ErrorResponseForContainerRegistry';
```