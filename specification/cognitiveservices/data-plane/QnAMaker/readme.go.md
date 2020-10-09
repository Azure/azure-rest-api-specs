## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: release_4_0
  - tag: runtime_release_4_0
  - tag: release_5_0_preview.1
```

### Tag: release_4_0 and go

These settings apply only when `--tag=release_4_0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_4_0' && $(go)
namespace: qnamaker
output-folder: $(go-sdk-folder)/services/cognitiveservices/v4.0/$(namespace)
```

### Tag: runtime_release_4_0 and go

These settings apply only when `--tag=runtime_release_4_0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'runtime_release_4_0' && $(go)
namespace: qnamakerruntime
output-folder: $(go-sdk-folder)/services/cognitiveservices/v4.0/$(namespace)
```

### Tag: release_5_0_preview.1 and go

These settings apply only when `--tag=release_5_0_preview.1 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_5_0_preview.1' && $(go)
namespace: qnamaker
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/cognitiveservices/v5.0-preview.1/$(namespace)
```
