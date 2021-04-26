## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: graphrbac
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: "1.6"
```

### Tag: 1.6 and go

These settings apply only when `--tag=1.6 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == '1.6' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/1.6/$(namespace)
```