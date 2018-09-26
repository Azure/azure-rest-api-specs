## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: containerinstance
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-09
  - tag: package-2018-06
  - tag: package-2018-04
  - tag: package-2018-02-preview
  - tag: package-2017-12-preview
  - tag: package-2017-10-preview
  - tag: package-2017-08-preview
```

### Tag: package-2018-09 and go

These settings apply only when `--tag=package-2018-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-09' && $(go)
output-folder: $(go-sdk-folder)/services/containerinstance/mgmt/2018-09-01/containerinstance
```

### Tag: package-2018-06 and go

These settings apply only when `--tag=package-2018-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-06' && $(go)
output-folder: $(go-sdk-folder)/services/containerinstance/mgmt/2018-06-01/containerinstance
```

### Tag: package-2018-04 and go

These settings apply only when `--tag=package-2018-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-04' && $(go)
output-folder: $(go-sdk-folder)/services/containerinstance/mgmt/2018-04-01/containerinstance
```

### Tag: package-2018-02-preview and go

These settings apply only when `--tag=package-2018-02-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-02-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/containerinstance/mgmt/2018-02-01-preview/containerinstance
```

### Tag: package-2017-12-preview and go

These settings apply only when `--tag=package-2017-12-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-12-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/containerinstance/mgmt/2017-12-01-preview/containerinstance
```

### Tag: package-2017-10-preview and go

These settings apply only when `--tag=package-2017-10-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-10-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/containerinstance/mgmt/2017-10-01-preview/containerinstance
```

### Tag: package-2017-08-preview and go

These settings apply only when `--tag=package-2017-08-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-08-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/containerinstance/mgmt/2017-08-01-preview/containerinstance
```
