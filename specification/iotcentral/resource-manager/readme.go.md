## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  namespace: iotcentral
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-06
  - tag: package-2018-09-01
```

### Tag: package-2021-06 and go

These settings apply only when `--tag=package-2021-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-06' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-06-01/$(namespace)
```

### Tag: package-2018-09-01 and go

These settings apply only when `--tag=package-2018-09-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-09-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-09-01/$(namespace)
```
