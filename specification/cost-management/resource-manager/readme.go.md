## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: costmanagement
  clear-output-folder: true
```

### Go multi-api
``` yaml $(go) && $(multiapi)
batch:
   - tag: package-2018-05
   - tag: package-2018-08-preview
   - tag: package-2019-01
   - tag: package-preview-2019-03
   - tag: package-2019-10
```

### Tag: package-2018-05 and go
These settings apply only when `--tag=package-2018-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-05' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-05-31/$(namespace)
```

### Tag: package-2018-08-preview and go
These settings apply only when `--tag=package-2018-08-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-08-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-08-01-preview/$(namespace)
```

### Tag: package-2019-01 and go
These settings apply only when `--tag=package-2019-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-01-01/$(namespace)
```

### Tag: package-preview-2019-03 and go
These settings apply only when `--tag=package-preview-2019-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-preview-2019-03' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-03-01/$(namespace)
```

### Tag: package-2019-10 and go
These settings apply only when `--tag=package-2019-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-10' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-10-01/$(namespace)
```
