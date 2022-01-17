## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript) && !$(profile)
typescript:
  azure-arm: true
  batch: true
  generate-metadata: true
batch:
  - package-managedapplications: true
```

```yaml $(typescript) && $(package-managedapplications) && !$(profile)
typescript:
  package-name: "@azure/arm-managedapplications"
  output-folder: "$(typescript-sdks-folder)/sdk/managedapplications/arm-managedapplications"
  clear-output-folder: true
```