## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: consumption
  clear-output-folder: true
```

### Go multi-api
``` yaml $(go) && $(multiapi)
batch:
   - tag: package-2017-04-preview
   - tag: package-2017-11
   - tag: package-2017-12-preview
   - tag: package-2018-01
   - tag: package-2018-03
   - tag: package-2018-05
   - tag: package-2018-06
   - tag: package-2018-08
   - tag: package-2018-10
```


### Tag: package-2017-04-preview and go

These settings apply only when `--tag=package-2017-04-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-04-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-04-24-preview/$(namespace)
```

### Tag: package-2017-11 and go
These settings apply only when `--tag=package-2017-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-11' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-11-30/$(namespace)
```

### Tag: package-2017-12-preview and go
These settings apply only when `--tag=package-2017-12-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-12-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-12-30-preview/$(namespace)
```

### Tag: package-2018-01 and go
These settings apply only when `--tag=package-2018-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-01-31/$(namespace)
```

### Tag: package-2018-03 and go
These settings apply only when `--tag=package-2018-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-03-31/$(namespace)
```

### Tag: package-2018-05 and go
These settings apply only when `--tag=package-2018-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-05' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-05-31/$(namespace)
```

### Tag: package-2018-06 and go
These settings apply only when `--tag=package-2018-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-06' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-06-30/$(namespace)
```

### Tag: package-2018-08 and go
These settings apply only when `--tag=package-2018-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-08' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-08-31/$(namespace)
```

### Tag: package-2018-10 and go
These settings apply only when `--tag=package-2018-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-10' && $(go)
output-folder: $(go-sdk-folder)/services/consumption/mgmt/2018-10-01/consumption
```
