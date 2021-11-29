## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  namespace: healthbot
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-06-10
  - tag: package-2020-12-08
```

### Tag: package-2021-06-10 and go

These settings apply only when `--tag=package-2021-06-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-06-10' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-06-10/$(namespace)
```

### Tag: package-2020-12-08 and go

These settings apply only when `--tag=package-2020-12-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-12-08' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-12-08/$(namespace)
```
