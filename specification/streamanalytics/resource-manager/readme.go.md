## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: streamanalytics
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-03-preview
```

### Tag: package-pure-2016-03 and go

These settings apply only when `--tag=package-pure-2016-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-pure-2016-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-03-01/$(namespace)
```

### Tag: package-pure-2017-04-preview and go

These settings apply only when `--tag=package-pure-2017-04-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-pure-2017-04-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-04-01-preview/$(namespace)
```

### Tag: package-2020-03-preview and go

These settings apply only when `--tag=package-2020-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-03-01-preview/$(namespace)