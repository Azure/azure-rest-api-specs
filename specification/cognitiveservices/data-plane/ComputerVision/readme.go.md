## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: computervision
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: release_2_0
  - tag: release_2_1
  - tag: release_3_0
  - tag: release_3_1
```

### Tag: release_2_0 and go

These settings apply only when `--tag=release_2_0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_2_0' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v2.0/$(namespace)
```

### Tag: release_2_1 and go

These settings apply only when `--tag=release_2_1 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_2_1' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v2.1/$(namespace)
```

### Tag: release_3_0 and go

These settings apply only when `--tag=release_3_0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_3_0' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v3.0/$(namespace)
```

### Tag: release_3_1_preview and go

These settings apply only when `--tag=release_3_1_preview_2 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_3_1_preview_2' && $(go)
output-folder: $(go-sdk-folder)/services/preview/cognitiveservices/v3.1-preview.2/$(namespace)
```

### Tag: release_3_1 and go

These settings apply only when `--tag=release_3_1 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_3_1' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v3.1/$(namespace)
```