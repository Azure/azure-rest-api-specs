## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: prediction
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: release_1_0
  - tag: release_3_0
  - tag: release_3_1
```

### Tag: release_1_0 and go

These settings apply only when `--tag=release_1_0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_1_0' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v1.1/customvision/$(namespace)
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

``` yaml $(tag) == 'release_3_0' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v3.1/customvision/$(namespace)
```
