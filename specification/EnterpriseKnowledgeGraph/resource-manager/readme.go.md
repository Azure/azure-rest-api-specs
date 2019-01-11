## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: EnterpriseKnowledgeGraphService
  clear-output-folder: true
```

### Go multi-api
``` yaml $(go) && $(multiapi)
batch:
   - tag: package-2018-12-31
   - tag: package-2018-12-31-preview
```

### Tag: package-2018-12 and go
These settings apply only when `--tag=package-2018-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-12' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/2018-12-31/$(namespace)
```

### Tag: package-2018-12-preview and go
These settings apply only when `--tag=package-2018-12-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-12-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/2018-12-31-preview/$(namespace)

