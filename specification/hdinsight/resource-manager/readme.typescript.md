## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-hdinsight"
  output-folder: "$(typescript-sdks-folder)/sdk/hdinsight/arm-hdinsight"
  generate-metadata: true
```

## Tag: package-hdinsightonaks-2023-06-preview and TypeScript

These settings apply only when `--tag=package-hdinsightonaks-2023-06-preview --typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(tag) == 'package-hdinsightonaks-2023-06-preview' && $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-hdinsightonaks"
  output-folder: "$(typescript-sdks-folder)/sdk/hdinsight/arm-hdinsightonaks"
  generate-metadata: true
```
