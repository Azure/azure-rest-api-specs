## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: speakerverification
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: release_2021-09-05
```

### Tag: release_release_2021-09-05 and go

These settings apply only when `--tag=release_2021-09-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_2021-09-05' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/2021-09-05/$(namespace)
```

### Tag: verification_2_0_preview and go

These settings apply only when `--tag=verification_2_0_preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'verification_2_0_preview' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v2.0-preview/$(namespace)
```
