## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-09-30-preview
  - tag: package-2018-08-preview
  - tag: package-2018-03
  - tag: package-2017-09
  - tag: package-2017-08
  - tag: package-2017-07
```

### Tag: package-2018-09-30-preview and go

These settings apply only when `--package-2018-09-30-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-09-30-preview' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/preview/containerservice/mgmt/2018-09-30-preview/containerservice
```

### Tag: package-2018-08-preview and go

These settings apply only when `--package-2018-08-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-08-preview' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/preview/containerservice/mgmt/2018-08-01-preview/containerservice
```

### Tag: package-2018-03 and go

These settings apply only when `--tag=package-2018-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-03' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-03-31/$(namespace)
```

### Tag: package-2017-09 and go

These settings apply only when `--tag=package-2017-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-09' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-09-30/$(namespace)
```

### Tag: package-2017-08 and go

These settings apply only when `--tag=package-2017-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-08' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-08-31/$(namespace)
```

### Tag: package-2017-07 and go

These settings apply only when `--tag=package-2017-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-07' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-07-01/$(namespace)
```