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
  package-name: "@azure/arm-containerregistrytasks"
  output-folder: "$(typescript-sdks-folder)/sdk/containerregistry/arm-containerregistrytasks"
  generate-metadata: true

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
