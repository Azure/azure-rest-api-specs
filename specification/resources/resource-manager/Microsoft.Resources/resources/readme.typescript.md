## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript) && !$(profile-content)
typescript:
  azure-arm: true
  batch: true
  generate-metadata: true
batch:
  - package-resources: true
```

```yaml $(typescript) && $(package-resources) && !$(profile-content)
typescript:
  package-name: "@azure/arm-resources"
  output-folder: "$(typescript-sdks-folder)/sdk/resources/arm-resources"
```

```yaml $(tag)=='package-resources-2018-05' && $(profile-content)=='profile-hybrid-2019-03-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-resources-profile-2019-03-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/resources/arm-resources-profile-2019-03-01-hybrid"
  batch:
    - tag: package-resources-2018-05
```

```yaml $(tag)=='package-resources-2019-10' && $(profile-content)=='profile-hybrid-2020-09-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-resources-profile-2020-09-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/resources/arm-resources-profile-2020-09-01-hybrid"
  batch:
    - tag: package-resources-2019-10
```
