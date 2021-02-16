## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: dataprotection
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-01
```

### Tag: package-2021-01 and go

These settings apply only when `--tag=package-2021-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-01' && $(go)
output-folder: $(go-sdk-folder)/services/stable/dataprotection/mgmt/2021-01-01/$(namespace)
```
