## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: botservice
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-preview-2021-05
  - tag: package-2021-03-01
  - tag: package-2017-12-01
  - tag: package-2018-07-12
```

### Tag: package-preview-2021-05 and go

These settings apply only when `--tag=package-preview-2021-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-preview-2021-05' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-05-01-preview/$(namespace)
```

### Tag: package-2021-03-01 and go

These settings apply only when `--tag=package-2021-03-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-03-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-03-01/$(namespace)
```

### Tag: package-2018-07-12 and go

These settings apply only when `--tag=package-2018-07-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-07-12' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-07-12/$(namespace)
```


### Tag: package-2017-12-01 and go

These settings apply only when `--tag=package-2017-12-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-12-01' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-12-01/$(namespace)
```
