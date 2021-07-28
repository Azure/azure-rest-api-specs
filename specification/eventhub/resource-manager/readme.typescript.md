## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript) && !$(profile)
typescript:
  azure-arm: true
  package-name: "@azure/arm-eventhub"
  output-folder: "$(typescript-sdks-folder)/sdk/eventhub/arm-eventhub"
  clear-output-folder: true
  generate-metadata: true
```

### Profile: profile-hybrid-2020-09-01

These settings apply only when `--profile=profile-hybrid-2020-09-01` is specified on the command line.

``` yaml $(profile)=='profile-hybrid-2020-09-01'
typescript:
  package-name: "@azure/arm-eventhub-profile-2020-09-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/eventhub/arm-eventhub-profile-2020-09-01-hybrid"
  clear-output-folder: true
  azure-arm: true
  generate-metadata: true
  batch:
    - tag: profile-hybrid-2020-09-01
```
