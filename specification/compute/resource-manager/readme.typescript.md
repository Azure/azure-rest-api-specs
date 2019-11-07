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
  package-name: "@azure/arm-compute"
  output-folder: "$(typescript-sdks-folder)/sdk/compute/arm-compute"
  clear-output-folder: true
  
```

### Profile: profile-hybrid-2019-03-01

These settings apply only when `--profile=profile-hybrid-2019-03-01` is specified on the command line.

``` yaml $(profile)=='profile-hybrid-2019-03-01'
typescript:
  package-name: "@azure/arm-compute-profile-2019-03-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/compute/arm-compute-profile-2019-03-01-hybrid"
  batch:
    - tag: profile-hybrid-2019-03-01
```
