## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # stop the simplifier from making Task conflict:
  skip-simplifier-on-namespace:
    - System.Threading.Tasks
  # last generated using AutoRest.1.0.0-Nightly20170212 with commit 3b0b26b4b6e3bc5e7cf3610b0866d310abb5b814
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.ContainerRegistry
  payload-flattening-threshold: 2
  output-folder: $(csharp-sdks-folder)/containerregistry/Microsoft.Azure.Management.ContainerRegistry/src/Generated
  clear-output-folder: true
```

### C# multi-api

``` yaml $(csharp) && $(multiapi)
batch:
  - tag: package-2019-06-preview
  - tag: package-2019-05
  - tag: package-2019-05-preview
  - tag: package-2019-04
  - tag: package-2018-09
  - tag: package-2018-02-preview
  - tag: package-2017-10
  - tag: package-2017-03
```

### Tag: package-2019-06-preview and csharp

These settings apply only when `--tag=package-2019-06-preview --csharp` is specified on the command line.
Please also specify `--csharp-sdk-folder=<path to the root directory of your azure-sdk-for-csharp clone>`.

``` yaml $(tag) == 'package-2019-06-preview' && $(csharp)
output-folder: $(csharp-sdk-folder)/services/$(namespace)/mgmt/2019-06-01-preview/$(namespace)
```

### Tag: package-2019-05 and csharp

These settings apply only when `--tag=package-2019-05 --csharp` is specified on the command line.
Please also specify `--csharp-sdk-folder=<path to the root directory of your azure-sdk-for-csharp clone>`.

``` yaml $(tag) == 'package-2019-05' && $(csharp)
output-folder: $(csharp-sdk-folder)/services/$(namespace)/mgmt/2019-05-01/$(namespace)
```

### Tag: package-2019-05-preview and csharp

These settings apply only when `--tag=package-2019-05-preview --csharp` is specified on the command line.
Please also specify `--csharp-sdk-folder=<path to the root directory of your azure-sdk-for-csharp clone>`.

``` yaml $(tag) == 'package-2019-05-preview' && $(csharp)
output-folder: $(csharp-sdk-folder)/services/$(namespace)/mgmt/2019-05-01-preview/$(namespace)
```

### Tag: package-2019-04 and csharp

These settings apply only when `--tag=package-2019-04 --csharp` is specified on the command line.
Please also specify `--csharp-sdk-folder=<path to the root directory of your azure-sdk-for-csharp clone>`.

``` yaml $(tag) == 'package-2019-04' && $(csharp)
output-folder: $(csharp-sdk-folder)/services/$(namespace)/mgmt/2019-04-01/$(namespace)
```

### Tag: package-2018-09 and csharp

These settings apply only when `--tag=package-2018-09 --csharp` is specified on the command line.
Please also specify `--csharp-sdk-folder=<path to the root directory of your azure-sdk-for-csharp clone>`.

``` yaml $(tag) == 'package-2018-09' && $(csharp)
output-folder: $(csharp-sdk-folder)/services/$(namespace)/mgmt/2018-09-01/$(namespace)
```

### Tag: package-2018-02-preview and csharp

These settings apply only when `--tag=package-2018-02-preview --csharp` is specified on the command line.
Please also specify `--csharp-sdk-folder=<path to the root directory of your azure-sdk-for-csharp clone>`.

``` yaml $(tag) == 'package-2018-02-preview' && $(csharp)
output-folder: $(csharp-sdk-folder)/services/preview/$(namespace)/mgmt/2018-02-01/$(namespace)
```

### Tag: package-2017-10 and csharp

These settings apply only when `--tag=package-2017-10 --csharp` is specified on the command line.
Please also specify `--csharp-sdk-folder=<path to the root directory of your azure-sdk-for-csharp clone>`.

``` yaml $(tag) == 'package-2017-10' && $(csharp)
output-folder: $(csharp-sdk-folder)/services/$(namespace)/mgmt/2017-10-01/$(namespace)
```

### Tag: package-2017-03 and csharp

These settings apply only when `--tag=package-2017-03 --csharp` is specified on the command line.
Please also specify `--csharp-sdk-folder=<path to the root directory of your azure-sdk-for-csharp clone>`.

``` yaml $(tag) == 'package-2017-03' && $(csharp)
output-folder: $(csharp-sdk-folder)/services/$(namespace)/mgmt/2017-03-01/$(namespace)
```
