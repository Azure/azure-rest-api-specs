## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/containerregistry/armcontainerregistry/v3
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
title: ContainerRegistryManagementClient
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
  - from: containerregistry_build.json
    where: $.definitions.Task.properties
    transform: >
      $.identity['$ref'] = '../../../Registry/stable/2025-11-01/containerregistry.json#/definitions/IdentityProperties';
  - from: containerregistry_build.json
    where: $.definitions.TaskRun.properties
    transform: >
      $.identity['$ref'] = '../../../Registry/stable/2025-11-01/containerregistry.json#/definitions/IdentityProperties';
  - from: containerregistry_build.json
    where: $.definitions.TaskRunUpdateParameters.properties
    transform: >
      $.identity['$ref'] = '../../../Registry/stable/2025-11-01/containerregistry.json#/definitions/IdentityProperties';
  - from: containerregistry_build.json
    where: $.definitions.TaskUpdateParameters.properties
    transform: >
      $.identity['$ref'] = '../../../Registry/stable/2025-11-01/containerregistry.json#/definitions/IdentityProperties';
  - from: containerregistry_build.json
    where: $.definitions.Run.allOf
    transform: >
      $['$ref'] = '../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource';
  - from: containerregistry_build.json
    where: $.definitions.TaskRun.allOf
    transform: >
      $['$ref'] = '../../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource';
  - from: containerregistry_build.json
    where: $.definitions.Resource.properties
    transform: >
      $.systemData['$ref'] = '../../../../../../common-types/resource-management/v6/types.json#/definitions/systemData';
  - from: containerregistry_build.json
    where: $.definitions.ProxyResource.properties
    transform: >
      $.systemData['$ref'] = '../../../../../../common-types/resource-management/v6/types.json#/definitions/systemData';
```

### Tag: package-2025-11

``` yaml $(go) && $(tag) == 'package-2025-11'
input-file:
  - stable/2025-11-01/containerregistry.json
  - ../RegistryTasks/preview/2025-03-01-preview/containerregistry_build.json
```
