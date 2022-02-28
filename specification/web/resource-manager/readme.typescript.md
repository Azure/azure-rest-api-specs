## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

## Common TypeScript settings

``` yaml $(typescript)
typescript:
  azure-arm: true
  generate-metadata: true
  payload-flattening-threshold: 1
```

``` yaml $(typescript) && !$(profile-content)
typescript:
  package-name: "@azure/arm-appservice"
  output-folder: "$(typescript-sdks-folder)/sdk/appservice/arm-appservice"
```

### Profile: profile-hybrid-2019-03-01

These settings apply only when `--profile-content=profile-hybrid-2019-03-01` is specified on the command line.

``` yaml $(profile-content)=='profile-hybrid-2019-03-01'
typescript:
  package-name: "@azure/arm-appservice-profile-2019-03-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/appservice/arm-appservice-profile-2019-03-01-hybrid"
  batch:
    - tag: profile-hybrid-2019-03-01
```

### Profile: profile-hybrid-2020-09-01

These settings apply only when `--profile-content=profile-hybrid-2020-09-01` is specified on the command line.

``` yaml $(profile-content)=='profile-hybrid-2020-09-01'
typescript:
  package-name: "@azure/arm-appservice-profile-2020-09-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/appservice/arm-appservice-profile-2020-09-01-hybrid"
  azure-arm: true
  generate-metadata: true
  batch:
    - tag: profile-hybrid-2020-09-01
```
