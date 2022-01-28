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
  package-name: "@azure/arm-authorization"
  output-folder: "$(typescript-sdks-folder)/sdk/authorization/arm-authorization"
```

### Profile: profile-hybrid-2019-03-01

These settings apply only when `--profile-content=profile-hybrid-2019-03-01` is specified on the command line.

``` yaml $(profile-content)=='profile-hybrid-2019-03-01'
typescript:
  package-name: "@azure/arm-authorization-profile-2019-03-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/authorization/arm-authorization-profile-2019-03-01-hybrid"
  batch:
    - tag: profile-hybrid-2019-03-01
```

### Profile: profile-hybrid-2020-09-01

These settings apply only when `--profile-content=profile-hybrid-2020-09-01` is specified on the command line.

``` yaml $(profile-content)=='profile-hybrid-2020-09-01'
typescript:
  package-name: "@azure/arm-authorization-profile-2020-09-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/authorization/arm-authorization-profile-2020-09-01-hybrid"
  batch:
    - tag: profile-hybrid-2020-09-01
```

### Profile: package-2020-10-01-preview

These settings apply only when `--profile-content=package-2020-10-01-preview` is specified on the command line.

``` yaml $(profile-content)=='package-2020-10-01-preview'
typescript:
  package-name: "@azure/arm-authorization-package-2020-10-01-preview"
  output-folder: "$(typescript-sdks-folder)/sdk/authorization/arm-authorization-package-2020-10-01-preview"
  batch:
    - tag: package-2020-10-01-preview
```
