## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  namespace: datamigration
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2017-11-15-preview
  - tag: package-2018-03-31-preview
  - tag: package-2018-04-19
  - tag: package-2018-07-15-preview
  - tag: package-preview-2021-10
```


### Tag: package-2017-11-15-preview and go

These settings apply only when `--tag=package-2017-11-15-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-11-15-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-11-15-preview/$(namespace)
```

### Tag: package-2018-03-31-preview and go

These settings apply only when `--tag=package-2018-03-31-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-03-31-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-03-31-preview/$(namespace)
```

### Tag: package-2018-04-19 and go

These settings apply only when `--tag=package-2018-04-19 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-04-19' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-04-19/$(namespace)
```

### Tag: package-2018-07-15-preview and go

These settings apply only when `--tag=package-2018-07-15-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-07-15-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-07-15-preview/$(namespace)
```

### Tag: package-preview-2021-10 and go

These settings apply only when `--tag=package-preview-2021-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-preview-2021-10' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-10-30-preview/$(namespace)
```