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

### Tag: package-2025-11-python

``` yaml $(tag) == 'package-2025-11-python'
input-file:
  - stable/2025-11-01/containerregistry.json
  - ../RegistryTasks/preview/2025-03-01-preview/containerregistry_build.json
```
