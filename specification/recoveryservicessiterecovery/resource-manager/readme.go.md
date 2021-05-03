## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  namespace: siterecovery
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-02
  - tag: package-2018-07
  - tag: package-2018-01
  - tag: package-2016-08
```

### Tag: package-2021-02 and go

These settings apply only when `--tag=package-2021-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-02' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2021-02-10/$(namespace)
```

### Tag: package-2018-07 and go

These settings apply only when `--tag=package-2018-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-07' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2018-07-10/$(namespace)
```

### Tag: package-2018-01 and go

These settings apply only when `--tag=package-2018-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-01' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2018-01-10/$(namespace)
```

### Tag: package-2016-08 and go

These settings apply only when `--tag=package-2016-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2016-08' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2016-08-10/$(namespace)
```
