These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```

### C# multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi)
batch:
  - tag: package-2020-01-01
  - tag: package-2018-06-01
  - tag: package-2017-12-01
  - tag: package-2020-02-14-privatepreview
  - tag: package-2020-01-01-privatepreview
  - tag: package-2018-06-01-privatepreview
  - tag: package-2017-12-01-preview
```

### Tag: package-2020-01-01 and C#

These settings apply only when `--tag=package-2020-01-01 --csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to the root directory of your azure-sdk-for-net clone>`.

``` yaml $(tag) == 'package-2020-01-01' && $(csharp)
csharp:
  namespace: Microsoft.Azure.Management.PostgreSQL
  output-folder: $(csharp-sdks-folder)/postgresql/$(namespace)/src/Generated
```

### Tag: package-2018-06-01 and C#

These settings apply only when `--tag=package-2018-06-01 --csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to the root directory of your azure-sdk-for-net clone>`.

``` yaml $(tag) == 'package-2018-06-01' && $(csharp)
csharp:
  namespace: Microsoft.Azure.Management.PostgreSQL
  output-folder: $(csharp-sdks-folder)/postgresql/$(namespace)/src/Generated
```

### Tag: package-2017-12-01 and C#

These settings apply only when `--tag=package-2017-12-01 --csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to the root directory of your azure-sdk-for-net clone>`.

``` yaml $(tag) == 'package-2017-12-01' && $(csharp)
csharp:
  namespace: Microsoft.Azure.Management.PostgreSQL
  output-folder: $(csharp-sdks-folder)/postgresql/$(namespace)/src/Generated
```

### Tag: package-2020-02-14-privatepreview and C#

These settings apply only when `--tag=package-2020-02-14-privatepreview --csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to the root directory of your azure-sdk-for-net clone>`.

``` yaml $(tag) == 'package-2020-02-14-privatepreview' && $(csharp)
csharp:
  namespace: Microsoft.Azure.Management.PostgreSQL.FlexibleServers
  output-folder: $(csharp-sdks-folder)/postgresql/$(namespace)/src/Generated
```

### Tag: package-2020-01-01-privatepreview and C#

These settings apply only when `--tag=package-2020-01-01-privatepreview --csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to the root directory of your azure-sdk-for-net clone>`.

``` yaml $(tag) == 'package-2020-01-01-privatepreview' && $(csharp)
csharp:
  namespace: Microsoft.Azure.Management.PostgreSQL
  output-folder: $(csharp-sdks-folder)/postgresql/$(namespace)/src/Generated
```

### Tag: package-2018-06-01-privatepreview and C#

These settings apply only when `--tag=package-2018-06-01-privatepreview --csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to the root directory of your azure-sdk-for-net clone>`.

``` yaml $(tag) == 'package-2018-06-01-privatepreview' && $(csharp)
csharp:
  namespace: Microsoft.Azure.Management.PostgreSQL
  output-folder: $(csharp-sdks-folder)/postgresql/$(namespace)/src/Generated
```

### Tag: package-2017-12-01-preview and C#

These settings apply only when `--tag=package-2017-12-01-preview --csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to the root directory of your azure-sdk-for-net clone>`.

``` yaml $(tag) == 'package-2017-12-01-preview' && $(csharp)
csharp:
  namespace: Microsoft.Azure.Management.PostgreSQL
  output-folder: $(csharp-sdks-folder)/postgresql/$(namespace)/src/Generated
```