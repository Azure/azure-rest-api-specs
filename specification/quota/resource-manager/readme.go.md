## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: quota
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-10-25
  - tag: package-preview-2019-07-19
```

### Tag: package-2020-10-25 and go

These settings apply only when `--tag=package-2020-10-25 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-10-25' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-10-25/$(namespace)
```

### Tag: package-preview-2019-07-19 and go

These settings apply only when `--tag=package-preview-2019-07-19 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-preview-2019-07-19' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-07-19-preview/$(namespace)
```
