## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
title: ContainerRegistryManagementClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-containerregistrytasks
namespace: azure.mgmt.containerregistrytasks
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistrytasks
```

``` yaml $(python)
directive:
  - from: swagger-document
    where: $.definitions.BuildStepProperties
    transform: >
        $['required'] = ['type'];
  - from: swagger-document
    where: $.definitions.BuildStepPropertiesUpdateParameters
    transform: >
        $['required'] = ['type'];
  - from: swagger-document
    where: $.definitions.QueueBuildRequest
    transform: >
        $['required'] = ['type']; 
  - from: swagger-document
    where: $.definitions.RunRequest
    transform: >
        $['required'] = ['type'];
  - from: swagger-document
    where: $.definitions.TaskStepProperties
    transform: >
        $['required'] = ['type']; 
  - from: swagger-document
    where: $.definitions.TaskStepUpdateParameters
    transform: >
        $['required'] = ['type'];
```