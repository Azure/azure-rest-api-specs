## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: guestconfiguration
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-06-25
  - tag: package-2021-01-25
```
### Tag: package-2021-01-25 and go

These settings apply only when `--tag=package-2021-01-25 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-01-25' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-01-25/$(namespace)
```

### Tag: package-2020-06-25 and go

These settings apply only when `--tag=package-2020-06-25 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-06-25' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-06-25/$(namespace)
```