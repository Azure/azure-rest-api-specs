## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: servicefabric
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: "6.2"
  - tag: "6.3"
```

### Tag: 6.2 and go

These settings apply only when `--tag=6.2 --go` is specified on the command line.

``` yaml $(tag) == '6.2' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/6.2/$(namespace)
```


### Tag: 6.3 and go

These settings apply only when `--tag=6.3 --go` is specified on the command line.

``` yaml $(tag) == '6.2' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/6.3/$(namespace)
```