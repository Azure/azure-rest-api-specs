## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: desktopvirtualization
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/desktopvirtualization/armdesktopvirtualization
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api
``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2019-01-23-preview
  - tag: package-2019-09-24-preview
  - tag: package-2019-12-10-preview
  - tag: package-2020-09-21-preview
  - tag: package-2020-10-19-preview
  - tag: package-2020-11-02-preview
  - tag: package-2020-11-10-preview
  - tag: package-2021-01-14-preview
  - tag: package-2021-02-01-preview
  - tag: package-2021-03-09-preview
  - tag: package-2021-04-01-preview
  - tag: package-preview-2021-09
```

### Tag: package-preview-2021-09 and go

These settings apply only when `--tag=package-preview-2021-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-preview-2021-09' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-09-03-preview/$(namespace)
```

### Tag: package-2021-04-01-preview and go

These settings apply only when `--tag=package-2021-04-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-04-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-04-01-preview/$(namespace)
```

### Tag: package-2021-03-09-preview and go

These settings apply only when `--tag=package-2021-03-09-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-03-09-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-03-09-preview/$(namespace)
```

### Tag: package-2021-02-01-preview and go

These settings apply only when `--tag=package-2021-02-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-02-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-02-01-preview/$(namespace)
```

### Tag: package-2021-01-14-preview and go

These settings apply only when `--tag=package-2021-01-14-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-01-14-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-01-14-preview/$(namespace)
```

### Tag: package-2020-11-10-preview and go

These settings apply only when `--tag=package-2020-11-10-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-11-10-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-11-10-preview/$(namespace)
```

### Tag: package-2020-11-02-preview and go

These settings apply only when `--tag=package-2020-11-02-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-11-02-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-11-02-preview/$(namespace)
```

### Tag: package-2020-10-19-preview and go

These settings apply only when `--tag=package-2020-10-19-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-10-19-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-10-19-preview/$(namespace)
```

### Tag: package-2020-09-21-preview and go

These settings apply only when `--tag=package-2020-09-21-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-09-21-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-09-21-preview/$(namespace)
```

### Tag: package-2019-12-10-preview and go

These settings apply only when `--tag=package-2019-12-10-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-12-10-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-12-10-preview/$(namespace)
```

### Tag: package-2019-09-24-preview and go

These settings apply only when `--tag=package-2019-09-24-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-09-24-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-09-24-preview/$(namespace)
```

### Tag: package-2019-01-23-preview and go

These settings apply only when `--tag=package-2019-01-23-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-01-23-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-01-23-preview/$(namespace)
```

