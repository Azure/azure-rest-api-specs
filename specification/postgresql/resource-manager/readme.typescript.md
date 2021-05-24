## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-postgresql"
  clear-output-folder: true
  generate-metadata: true
```

### TypeScript multi-api

```yaml $(typescript) && $(multiapi)
batch:
  - tag: package-2020-01-01
  - tag: package-2021-04-10-privatepreview
```


### Tag: package-2021-04-10-privatepreview and TypeScript

These settings apply only when `--tag=package-2021-04-10-privatepreview --typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to the root directory of your azure-sdk-for-typescript clone>`.

``` yaml $(tag) == 'package-2021-04-10-privatepreview' && $(typescript)
output-folder: "$(typescript-sdks-folder)/sdk/postgresql/arm-postgresql/
```

### Tag: package-2020-01-01 and TypeScript

These settings apply only when `--tag=package-2020-01-01 --typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to the root directory of your azure-sdk-for-typescript clone>`.

``` yaml $(tag) == 'package-2020-01-01' && $(typescript)
output-folder: "$(typescript-sdks-folder)/sdk/postgresql/arm-postgresql-flexibleserver/
```

