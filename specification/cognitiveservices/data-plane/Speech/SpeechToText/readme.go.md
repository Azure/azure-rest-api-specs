## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: authoring
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: 2_0
  - tag: 3_0
```

### Tag: 2_0 and go

These settings apply only when `--tag=2_0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == '2_0' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v2.0/speech/speechtotext/$(namespace)
```

### Tag: 3_0 and go

These settings apply only when `--tag=3_0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == '3_0' && $(go)
output-folder: $(go-sdk-folder)/services/preview/cognitiveservices/v3.0/speech/speechtotext/$(namespace)
```