## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: databox
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/databox/armdatabox
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
- rename-model:
    from: 'JobDetails'
    to: 'CommonJobDetails'
- rename-model:
    from: 'JobSecrets'
    to: 'CommonJobSecrets'
- rename-model:
    from: 'ScheduleAvailabilityRequest'
    to: 'CommonScheduleAvailabilityRequest'
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-01
  - tag: package-2019-09
  - tag: package-2020-04
  - tag: package-2020-11
  - tag: package-2021-03
  - tag: package-2021-05
  - tag: package-2021-08-preview
  - tag: package-2021-12
  - tag: package-2022-02
  - tag: package-2022-09
  - tag: package-2022-10
  - tag: package-2022-12
  - tag: package-2023-03
  - tag: package-2023-12
```

### Tag: package-2018-01 and go

These settings apply only when `--tag=package-2018-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-01-01/$(namespace)
```

### Tag: package-2019-09 and go

These settings apply only when `--tag=package-2019-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-09' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-09-01/$(namespace)
```

### Tag: package-2020-04 and go

These settings apply only when `--tag=package-2020-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-04' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-04-01/$(namespace)
```

### Tag: package-2020-11 and go

These settings apply only when `--tag=package-2020-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-11' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-11-01/$(namespace)
```

### Tag: package-2021-03 and go

These settings apply only when `--tag=package-2021-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-03-01/$(namespace)
```

### Tag: package-2021-05 and go

These settings apply only when `--tag=package-2021-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-05' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-05-01/$(namespace)
```

### Tag: package-2021-08-preview and go

These settings apply only when `--tag=package-2021-08-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-08-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-08-01-preview/$(namespace)
```

### Tag: package-2021-12 and go

These settings apply only when `--tag=package-2021-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-12' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-12-01/$(namespace)
```

### Tag: package-2022-02 and go

These settings apply only when `--tag=package-2022-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2022-02' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2022-02-01/$(namespace)
```

### Tag: package-2022-09 and go

These settings apply only when `--tag=package-2022-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2022-09' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2022-09-01/$(namespace)
```

### Tag: package-2022-10 and go

These settings apply only when `--tag=package-2022-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2022-10' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2022-10-01/$(namespace)
```

### Tag: package-2022-12 and go

These settings apply only when `--tag=package-2022-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2022-12' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2022-12-01/$(namespace)
```

### Tag: package-2023-03 and go

These settings apply only when `--tag=package-2023-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2023-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2023-03-01/$(namespace)
```

### Tag: package-2023-12 and go

These settings apply only when `--tag=package-2023-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2023-12' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2023-12-01/$(namespace)
```