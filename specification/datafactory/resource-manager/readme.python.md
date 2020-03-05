## Python

These settings apply only when `--python` is specified on the command line.
``` yaml $(python)

python:
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azure-mgmt-datafactory
  clear-output-folder: true
add-credential: true
directive:
  - from: swagger-document
    where: $..parameters[?(@.in=='body')]
    transform: >
      $['x-ms-client-flatten'] = true;
    reason: Flatten everything for Azure CLI
  - from: swagger-document
    where: $.definitions[*].properties.*
    transform: >
      $['x-ms-client-flatten'] = true;
    reason: Flatten everything for Azure CLI
  - from: swagger-document
    where: $.definitions[?(@.discriminator)]
    transform: >
      $['x-ms-client-flatten'] = false;
  - from: swagger-document
    where: $.definitions[?(@.discriminator)].properties.*
    transform: >
      $['x-ms-client-flatten'] = false;
  - from: swagger-document
    where: $.definitions.FactoryRepoUpdate.properties.repoConfiguration
    transform: >
      $['x-ms-client-flatten'] = false;
    reason: manually don't flatten the polymorphic base class
  - from: swagger-document
    where: $.definitions.FactoryProperties.properties.repoConfiguration
    transform: >
      $['x-ms-client-flatten'] = false;
    reason: manually don't flatten the polymorphic base class
  - from: swagger-document
    where: $.definitions.CmdkeySetupTypeProperties.properties.password
    transform: >
      $['x-ms-client-flatten'] = false;
    reason: manually don't flatten the polymorphic base class
  - from: swagger-document
    where: $.definitions.LicensedComponentSetupTypeProperties.properties.licenseKey
    transform: >
      $['x-ms-client-flatten'] = false;
    reason: manually don't flatten the polymorphic base class
  - from: swagger-document
    where: $.definitions.*.properties.servicePrincipalKey
    transform: >
      $['x-ms-client-flatten'] = false;
    reason: manually don't flatten the polymorphic base class
  - from: swagger-document
    where: $.definitions.DataFlowResource.properties.properties
    transform: >
      $['x-ms-client-flatten'] = false;
    reason: manually don't flatten the polymorphic base class
  - from: swagger-document
    where: $.definitions.DataFlowDebugResource.properties.properties
    transform: >
      $['x-ms-client-flatten'] = false;
    reason: manually don't flatten the polymorphic base class
  - from: swagger-document
    where: $.definitions.IntegrationRuntimeResource.properties.properties
    transform: >
      $['x-ms-client-flatten'] = false;
    reason: manually don't flatten the polymorphic base class
  - from: swagger-document
    where: $.definitions.IntegrationRuntimeDebugResource.properties.properties
    transform: >
      $['x-ms-client-flatten'] = false;
    reason: manually don't flatten the polymorphic base class
  - from: swagger-document
    where: $.definitions.LinkedServiceResource.properties.properties
    transform: >
      $['x-ms-client-flatten'] = false;
```

``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/datafactory/azure-mgmt-datafactory/azure/mgmt/datafactory
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/datafactory/azure-mgmt-datafactory
```