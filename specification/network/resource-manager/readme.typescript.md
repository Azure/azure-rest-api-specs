## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

## Common TypeScript settings

``` yaml $(typescript)
typescript:
  azure-arm: true
  generate-metadata: true
```

``` yaml $(typescript) && !$(profile)
typescript:
  package-name: "@azure/arm-network"
  output-folder: "$(typescript-sdks-folder)/sdk/network/arm-network"
  clear-output-folder: true
```

### Profile: profile-hybrid-2019-03-01

These settings apply only when `--profile=profile-hybrid-2019-03-01` is specified on the command line.

``` yaml $(profile)=='profile-hybrid-2019-03-01'
typescript:
  package-name: "@azure/arm-network-profile-2019-03-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/network/arm-network-profile-2019-03-01-hybrid"
  clear-output-folder: true
  batch:
    - tag: profile-hybrid-2019-03-01
```
