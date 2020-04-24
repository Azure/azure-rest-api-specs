## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: translation.batch
  clear-output-folder: true
```


### Tag: release_1_0_review and go

These settings apply only when `--tag=release_1_0_preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_1_0_preview' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v1.0.preview/$(namespace)
```
