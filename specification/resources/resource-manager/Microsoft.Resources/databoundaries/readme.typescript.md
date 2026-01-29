## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript) && !$(profile-content)
typescript:
  azure-arm: true
  batch: true
  generate-metadata: true
batch:
  - package-databoundaries: true
```

```yaml $(typescript) && $(package-databoundaries) && !$(profile-content)
title: DataboundariesManegementClient
typescript:
  package-name: "@azure/arm-databoundaries"
  output-folder: "$(typescript-sdks-folder)/sdk/databoundaries/arm-databoundaries"
```
