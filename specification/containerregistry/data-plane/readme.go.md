## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: containerregistry
  clear-output-folder: true
  add-credentials: true

  # Non standard header use, still awaiting checks here
  directive:
    - remove-operation: UploadBlobChunkSpecified
    - remove-operation: UploadBlobChunk
    - remove-model: UploadBlobChunkSpecifiedHeaders
    - remove-model: UploadBlobChunkHeaders
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2019-07
```

### Tag: package-2019-07 and go

These settings apply only when `--tag=package-2019-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-07' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/runtime/2019-07/$(namespace)
```
