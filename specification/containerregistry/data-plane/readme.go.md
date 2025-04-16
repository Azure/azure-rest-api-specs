## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
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
