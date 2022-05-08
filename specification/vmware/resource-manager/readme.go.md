## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: avs
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-12-01
  - tag: package-2021-06-01
  - tag: package-2021-01-01-preview
  - tag: package-2020-07-17-preview
  - tag: package-2020-03-20
```

### Tag: package-2021-12-01 and go

These settings apply only when `--tag=package-2021-12-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-12-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-12-01/$(namespace)
```

### Tag: package-2021-06-01 and go

These settings apply only when `--tag=package-2021-06-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-06-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-06-01/$(namespace)
```

### Tag: package-2021-01-01-preview and go

These settings apply only when `--tag=package-2021-01-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-01-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-01-01-preview/$(namespace)
```

### Tag: package-2020-07-17-preview and go

These settings apply only when `--tag=package-2020-07-17-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-07-17-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-07-17-preview/$(namespace)
```

### Tag: package-2020-03-20 and go

These settings apply only when `--tag=package-2020-03-20 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03-20' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-03-20/$(namespace)
```
