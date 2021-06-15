## Csharp

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.PostgreSQL
  clear-output-folder: true
```

### Tag: package-2021-06-01 and csharp

These settings apply only when `--tag=package-2021-06-01 --csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to the root directory of your azure-sdk-for-csharp clone>`.

``` yaml $(tag) == 'package-2021-06-01' && $(csharp)
output-folder: $(csharp-sdks-folder)/postgresql/Microsoft.Azure.Management.PostgreSQL/src/postgresqlflexibleservers/Generated
```

### Tag: package-2020-01-01 and csharp

These settings apply only when `--tag=package-2020-01-01 --csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to the root directory of your azure-sdk-for-csharp clone>`.

``` yaml $(tag) == 'package-2021-06-01' && $(csharp)
output-folder: $(csharp-sdks-folder)/postgresql/Microsoft.Azure.Management.PostgreSQL/src/postgresql/Generated
```