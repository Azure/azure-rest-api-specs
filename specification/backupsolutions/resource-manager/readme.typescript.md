## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript) && !$(profile)
typescript:
  azure-arm: true
  batch: true
  generate-metadata: true
batch:
  - package-vmwareapplications: true
```

```yaml $(typescript) && $(package-vmwareapplications) && !$(profile)
typescript:
  package-name: "@azure/arm-vmwareapplications"
  output-folder: "$(typescript-sdks-folder)/sdk/vmwareapplications/arm-vmwareapplications"
  clear-output-folder: true
```