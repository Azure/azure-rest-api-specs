## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: attestation
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-09-01
  - tag: package-2020-10-01
```

### Tag: package-2018-09-01 and go

These settings apply only when `--tag=package-2018-09-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-09-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-09-01/$(namespace)
```

These settings apply only when `--tag=package-2020-10-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-10-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-10-01/$(namespace)
```
