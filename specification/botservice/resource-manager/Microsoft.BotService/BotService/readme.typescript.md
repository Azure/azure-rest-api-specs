## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

## Common TypeScript settings

``` yaml $(typescript)
typescript:
  azure-arm: true
  generate-metadata: true
```

``` yaml $(typescript) && !$(profile-content)
typescript:
  package-name: "@azure/arm-botservice"
  output-folder: "$(typescript-sdks-folder)/sdk/botservice/arm-botservice"
```
