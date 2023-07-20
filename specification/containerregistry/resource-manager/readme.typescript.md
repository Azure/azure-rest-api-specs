## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

### Rename OS
```yaml
modelerfour:
  naming:
    override:
      OS: $DO_NOT_NORMALIZE$OS
```

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-containerregistry"
  output-folder: "$(typescript-sdks-folder)/sdk/containerregistry/arm-containerregistry"
  generate-metadata: true

directive:
  - from: containerregistry_build.json
    where: $.definitions.TaskRun.properties
    transform: >
      $['identity']['$ref'] = "../2023-06-01-preview/containerregistry.json#/definitions/IdentityProperties";
  - from: containerregistry_build.json
    where: $.definitions.Task.properties
    transform: >
      $['identity']['$ref'] = "../2023-06-01-preview/containerregistry.json#/definitions/IdentityProperties";
  - from: containerregistry_build.json
    where: $.definitions.TaskRunUpdateParameters.properties
    transform: >
      $['identity']['$ref'] = "../2023-06-01-preview/containerregistry.json#/definitions/IdentityProperties";
  - from: containerregistry_build.json
    where: $.definitions.TaskUpdateParameters.properties
    transform: >
      $['identity']['$ref'] = "../2023-06-01-preview/containerregistry.json#/definitions/IdentityProperties";
  - from: containerregistry_build.json
    where: $.definitions
    transform: >
      delete $.IdentityProperties;
  - from: containerregistry_build.json
    where: $.definitions
    transform: >
      delete $.UserIdentityProperties;
```
