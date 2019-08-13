## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: redis
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
tag: 2019-07-19-preview
```

### Tag: package-2019-07-19-preview and go

These settings apply only when `--tag=package-2019-07-19-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-07-19-preview' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-07-19-preview/$(namespace)
```
