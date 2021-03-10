## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: true
  generate-metadata: true
  batch: true
batch:
  - package-source-control-configurations: true
  - package-extensions: true
```

```yaml $(typescript) && $(package-source-control-configurations) && !$(profile)
typescript:
  package-name: "@azure/kubernetesconfiguration-source-control-configurations"
  output-folder: "$(typescript-sdks-folder)/sdk/kubernetesconfiguration/kubernetesconfiguration-source-control-configurations"
  clear-output-folder: true
```

```yaml $(typescript) && $(package-extensions) && !$(profile)
typescript:
  package-name: "@azure/kubernetesconfiguration-extensions"
  output-folder: "$(typescript-sdks-folder)/sdk/kubernetesconfiguration/kubernetesconfiguration-extensions"
  clear-output-folder: true
```