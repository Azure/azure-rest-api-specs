## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: desktopvirtualization
  clear-output-folder: true
```

### Go multi-api
``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2019-01-23-preview
  - tag: package-2019-09-24-preview
  - tag: package-2019-12-10-preview
  - tag: package-2020-09-21-preview
  - tag: package-2020-10-19-preview
```
### Tag: package-2020-10-19-preview and go

These settings apply only when `--tag=package-2020-10-19-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-10-19-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-10-19-preview/$(namespace)
```

### Tag: package-2020-09-21-preview and go

These settings apply only when `--tag=package-2020-09-21-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-09-21-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-09-21-preview/$(namespace)
```

### Tag: package-2019-12-10-preview and go

These settings apply only when `--tag=package-2019-12-10-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-12-10-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-12-10-preview/$(namespace)
```

### Tag: package-2019-09-24-preview and go

These settings apply only when `--tag=package-2019-09-24-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-09-24-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-09-24-preview/$(namespace)
```

### Tag: package-2019-01-23-preview and go

These settings apply only when `--tag=package-2019-01-23-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-01-23-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-01-23-preview/$(namespace)
```

