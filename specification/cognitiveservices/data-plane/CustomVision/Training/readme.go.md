## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: training
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: release_3_2
  - tag: release_1_0
  - tag: release_2_1
  - tag: release_2_2
  - tag: release_3_0
  - tag: release_3_1
  - tag: release_3_2
  - tag: release_3_3
```

### Tag: release_1_0 and go

These settings apply only when `--tag=release_1_0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_1_0' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v1.2/customvision/$(namespace)
```

### Tag: release_2_1 and go

These settings apply only when `--tag=release_2_1 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_2_1' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v2.1/customvision/$(namespace)
```

### Tag: release_2_2 and go

These settings apply only when `--tag=release_2_2 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_2_2' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v2.2/customvision/$(namespace)
```

### Tag: release_3_0 and go

These settings apply only when `--tag=release_3_0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_3_0' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v3.0/customvision/$(namespace)
```

### Tag: release_3_1 and go

These settings apply only when `--tag=release_3_1 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_3_1' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v3.1/customvision/$(namespace)
```

### Tag: release_3_2 and go

These settings apply only when `--tag=release_3_2 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_3_2' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v3.2/customvision/$(namespace)
```

### Tag: release_3_3 and go

These settings apply only when `--tag=release_3_3 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_3_3' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v3.3/customvision/$(namespace)
```