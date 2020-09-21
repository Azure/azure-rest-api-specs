## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: avs
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-07-17-preview
  - tag: package-2020-03-20
  - tag: package-2019-08-09-preview
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

### Tag: package-2019-08-09-preview and go

These settings apply only when `--tag=package-2019-08-09-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-08-09-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-08-09-preview/$(namespace)
```
