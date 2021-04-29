## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: postgresqlhsc
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-10-05-privatepreview
```

### Tag: package-2020-10-05-privatepreview and go

These settings apply only when `--tag=package-2020-10-05-privatepreview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-10-05-privatepreview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-10-05-preview/$(namespace)
```