## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: workloadmonitor
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-01-13-preview
  - tag: package-2018-08-31-preview
```

### Tag: package-2018-08-31-preview and go

These settings apply only when `--tag=package-2018-08-31-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-08-31-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/workloadmonitor/mgmt/2018-08-31-preview/workloadmonitor
```

### Tag: package-2020-01-13-preview and go

These settings apply only when `--tag=package-2020-01-13-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-01-13-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/workloadmonitor/mgmt/2020-01-13-preview/workloadmonitor
```
