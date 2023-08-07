## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-deviceprovisioningservices"
  output-folder: "$(typescript-sdks-folder)/sdk/deviceprovisioningservices/arm-deviceprovisioningservices"
  generate-metadata: true

directive:
  - rename-model:
      from: 'SharedAccessSignatureAuthorizationRule[AccessRightsDescription]'
      to: SharedAccessSignatureAuthorizationRule
  - from: iotdps.json
    where: $.definitions.Resource.properties.resourcegroup
    transform: >
      $["readOnly"] = true
  - from: iotdps.json
    where: $.definitions.Resource.properties.subscriptionid
    transform: >
      $["readOnly"] = true
```
