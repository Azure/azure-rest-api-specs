## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to the root directory of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: "@azure/arm-cdn"
  output-folder: "$(typescript-sdks-folder)/sdk/cdn/arm-cdn"
  generate-metadata: true

modelerfour:
  naming:
    override:
      AFDProfiles: $DO_NOT_NORMALIZE$AfdProfiles
      AFDCustomDomains: $DO_NOT_NORMALIZE$AfdCustomDomains
      AFDEndpoints: $DO_NOT_NORMALIZE$AfdEndpoints
      AFDOriginGroups: $DO_NOT_NORMALIZE$AfdOriginGroups
      AFDOrigins: $DO_NOT_NORMALIZE$AfdOrigins
```
