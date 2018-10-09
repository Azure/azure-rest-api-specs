## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: batch
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2017-05.5.0
  - tag: package-2018-03.6.1
  - tag: package-2018-08.7.0
```

### Tag: package-2018-08.7.0 and go

These settings apply only when `--tag=package-2018-08.7.0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-08.7.0' && $(go)
output-folder: $(go-sdk-folder)/services/batch/2018-08-01.7.0/batch
```

### Tag: package-2018-03.6.1 and go

These settings apply only when `--tag=package-2018-03.6.1 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-03.6.1' && $(go)
output-folder: $(go-sdk-folder)/services/batch/2018-03-01.6.1/batch
```

### Tag: package-2017-09.6.0 and go

These settings apply only when `--tag=package-2017-09.6.0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-09.6.0' && $(go)
output-folder: $(go-sdk-folder)/services/batch/2017-09-01.6.0/batch
```

### Tag: package-2017-06.5.1 and go

These settings apply only when `--tag=package-2017-06.5.1 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-06.5.1' && $(go)
output-folder: $(go-sdk-folder)/services/batch/2017-06-01.5.1/batch
```

### Tag: package-2017-05.5.0 and go

These settings apply only when `--tag=package-2017-05.5.0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-05.5.0' && $(go)
output-folder: $(go-sdk-folder)/services/batch/2017-05-01.5.0/batch
```

### Tag: package-2017-01.4.0 and go

These settings apply only when `--tag=package-2017-01.4.0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-01.4.0' && $(go)
output-folder: $(go-sdk-folder)/services/batch/2017-01-01.4.0/batch
```

### Tag: package-2016-07.3.1 and go

These settings apply only when `--tag=package-2016-07.3.1 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2016-07.3.1' && $(go)
output-folder: $(go-sdk-folder)/services/batch/2016-07-01.3.1/batch
```

### Tag: package-2016-02.3.0 and go

These settings apply only when `--tag=package-2016-02.3.0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2016-02.3.0' && $(go)
output-folder: $(go-sdk-folder)/services/batch/2016-02-01.3.0/batch
```

### Tag: package-2015-12.2.2 and go

These settings apply only when `--tag=package-2017-05.5.0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-05.5.0' && $(go)
output-folder: $(go-sdk-folder)/services/batch/2015-12-01.2.2/batch
```