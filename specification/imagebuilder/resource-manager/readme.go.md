## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: virtualmachineimagebuilder
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-02
  - tag: package-2018-02
  - tag: package-2019-02
  - tag: package-preview-2019-05
```

### Tag: package-2020-02

These settings apply only when `--tag=package-2020-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-02' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-02-01/$(namespace)
```

### Tag: package-2018-02

These settings apply only when `--tag=package-2018-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-02' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-02-01-preview/$(namespace)
```

### Tag: package-2019-02

These settings apply only when `--tag=package-2019-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-02' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-02-01-preview/$(namespace)
```

### Tag: package-preview-2019-05

These settings apply only when `--tag=package-preview-2019-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-preview-2019-05' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-05-01-preview/$(namespace)
```