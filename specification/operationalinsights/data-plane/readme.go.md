## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: operationalinsights
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: v1
```

### Tag: v1 and go

These settings apply only when `--tag=v1 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='v1' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/v1/$(namespace)
directive:
  - from: swagger-document
    where: $.definitions.table.properties.rows.items.items
    transform: $.type = "object"
```