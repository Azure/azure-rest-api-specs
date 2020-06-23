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
  - tag: package-2020-06
  - tag: package-2020-04
  - tag: package-2020-03
  - tag: package-2020-02
  - tag: package-2020-01
  - tag: package-2019-11
  - tag: package-2019-10-27-preview
  - tag: package-2019-10
  - tag: package-2019-08
  - tag: package-2019-06
  - tag: package-2019-04
  - tag: package-2019-02
  - tag: package-2019-09-30-preview
  - tag: package-2018-09-30-preview
  - tag: package-2018-08-preview
  - tag: package-2018-03
  - tag: package-2017-09
  - tag: package-2017-08
  - tag: package-2017-07
```
### Tag: package-2020-06 and go

These settings apply only when `--package-2020-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-06' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-06-01/$(namespace)
```

### Tag: package-2020-04 and go

These settings apply only when `--package-2020-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-04' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-04-01/$(namespace)
```

### Tag: package-2020-03 and go

These settings apply only when `--package-2020-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-03' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-03-01/$(namespace)
```

### Tag: package-2020-02 and go

These settings apply only when `--package-2020-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-02' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-02-01/$(namespace)
```

### Tag: package-2020-01 and go

These settings apply only when `--package-2020-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-01' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-01-01/$(namespace)
```

### Tag: package-2019-11 and go

These settings apply only when `--package-2019-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-11' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-11-01/$(namespace)
```

### Tag: package-2019-10-27-preview and go

These settings apply only when `--package-2019-10-27-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-10-27-preview' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-10-27-preview/$(namespace)
```

### Tag: package-2019-10 and go

These settings apply only when `--package-2019-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-10' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-10-01/$(namespace)
```

### Tag: package-2019-08 and go

These settings apply only when `--package-2019-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-08' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-08-01/$(namespace)
```

### Tag: package-2019-06 and go

These settings apply only when `--package-2019-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-06' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-06-01/$(namespace)
```

### Tag: package-2019-04 and go

These settings apply only when `--package-2019-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-04' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-04-30/$(namespace)
```

### Tag: package-2019-02 and go

These settings apply only when `--package-2019-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-02' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-02-01/$(namespace)
```

### Tag: package-2018-09-30-preview and go

These settings apply only when `--package-2018-09-30-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-09-30-preview' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/preview/containerservice/mgmt/2018-09-30-preview/containerservice
```

### Tag: package-2019-09-30-preview and go

These settings apply only when `--package-2019-09-30-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-09-30-preview' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/preview/containerservice/mgmt/2019-09-30-preview/containerservice
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
