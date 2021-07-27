## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: insights
  clear-output-folder: true
```

### Go mult-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2015-05
  - tag: package-2020-02-02
```

### Tag: package-2015-05 and go

These settings apply only when `--tag=package-2015-05 --go` is specified on he command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-05' && $(go)
output-folder: $(go-sdk-folder)/services/appinsights/mgmt/2015-05-01/$(namespace)
```

### Tag: package-2020-02-02 and go

These settings apply only when `--tag=package-2020-02-02 --go` is specified on he command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-02-02' && $(go)
output-folder: $(go-sdk-folder)/services/appinsights/mgmt/2020-02-02/$(namespace)
```
