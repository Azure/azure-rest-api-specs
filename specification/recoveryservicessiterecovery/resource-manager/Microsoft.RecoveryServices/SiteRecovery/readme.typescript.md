## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-recoveryservices-siterecovery"
  output-folder: "$(typescript-sdks-folder)/sdk/recoveryservicessiterecovery/arm-recoveryservices-siterecovery"
  generate-metadata: true

directive: 
  - from: swagger-document
    where: $.parameters.ResourceGroupName
    transform: >
      $["x-ms-parameter-location"] = "method"; 
      
  - from: swagger-document
    where: $.parameters.ResourceName
    transform: >
      $["x-ms-parameter-location"] = "method";
```
