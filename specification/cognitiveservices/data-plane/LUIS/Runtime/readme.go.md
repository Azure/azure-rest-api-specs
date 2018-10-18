## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: runtime
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: runtime_2_0
```

### Tag: runtime_2_0 and go

These settings apply only when `--tag=runtime_2_0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'runtime_2_0' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/v2.0/luis/$(namespace)
```