## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: backup
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2017-07
  - tag: package-2016-12
  - tag: package-2016-06
```

### Tag: package-2017-07 and go

These settings apply only when `--tag=package-2017-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-07' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2017-07-01/backup
```

### Tag: package-2016-12 and go

These settings apply only when `--tag=package-2016-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2016-12' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2016-12-01/backup
```

### Tag: package-2016-06 and go

These settings apply only when `--tag=package-2016-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2016-06' && $(go)
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2016-06-01/backup
```
