## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: automation
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2015-10
  - tag: package-2017-05-preview
  - tag: package-2018-01-preview
  - tag: package-2018-06-preview
```

### Tag: package-2015-10 and go

These settings apply only when `--tag=package-2015-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-10' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2015-10-31/$(namespace)
```

### Tag: package-2017-05-preview and go

These settings apply only when `--tag=package-2017-05-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-05-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-05-15-preview/$(namespace)
```

### Tag: package-2018-01-preview and go

These settings apply only when `--tag=package-2018-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-01-15-preview/$(namespace)
```

### Tag: package-2018-06-preview and go

These settings apply only when `--tag=package-2018-06-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-06-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-06-30-preview/$(namespace)
```