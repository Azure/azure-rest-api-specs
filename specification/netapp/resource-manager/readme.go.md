## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: netapp
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-netapp-2020-07-01
  - tag: package-netapp-2020-06-01
  - tag: package-netapp-2020-03-01  
  - tag: package-netapp-2020-02-01
  - tag: package-netapp-2019-11-01
  - tag: package-netapp-2019-10-01
  - tag: package-netapp-2019-08-01
  - tag: package-netapp-2019-07-01
  - tag: package-netapp-2019-06-01
  - tag: package-netapp-2019-05-01
  - tag: package-2017-08-15
```
### Tag: package-netapp-2020-07-01 and go

These settings apply only when `--tag=package-netapp-2020-07-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-netapp-2020-07-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-07-01/$(namespace)  
```
### Tag: package-netapp-2020-06-01 and go

These settings apply only when `--tag=package-netapp-2020-06-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-netapp-2020-06-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-06-01/$(namespace)  
```
### Tag: package-netapp-2020-03-01 and go

These settings apply only when `--tag=package-netapp-2020-03-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-netapp-2020-03-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-03-01/$(namespace)
```
### Tag: package-netapp-2020-02-01 and go

These settings apply only when `--tag=package-netapp-2020-02-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-netapp-2020-02-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-02-01/$(namespace)
```


### Tag: package-netapp-2019-11-01 and go

These settings apply only when `--tag=package-netapp-2019-11-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-netapp-2019-11-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-11-01/$(namespace)
```

### Tag: package-netapp-2019-10-01 and go

These settings apply only when `--tag=package-netapp-2019-10-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-netapp-2019-10-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-10-01/$(namespace)
```

### Tag: package-netapp-2019-08-01 and go

These settings apply only when `--tag=package-netapp-2019-08-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-netapp-2019-08-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-08-01/$(namespace)
```

### Tag: package-netapp-2019-07-01 and go

These settings apply only when `--tag=package-netapp-2019-07-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-netapp-2019-07-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-07-01/$(namespace)
```

### Tag: package-netapp-2019-06-01 and go

These settings apply only when `--tag=package-netapp-2019-06-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-netapp-2019-06-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-06-01/$(namespace)
```

### Tag: package-netapp-2019-05-01 and go

These settings apply only when `--tag=package-netapp-2019-05-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-netapp-2019-05-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-05-01/$(namespace)
```

### Tag: package-2017-08-15 and go

These settings apply only when `--tag=package-2017-08-15 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-08-15' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-08-15/$(namespace)
```
