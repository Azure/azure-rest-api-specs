## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: servicefabric
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: "6.2"
  - tag: "6.3"
  - tag: "6.4"
  - tag: "6.5"
  - tag: "7.0"
  - tag: "7.2"
```

### Tag: 6.2 and go

These settings apply only when `--tag=6.2 --go` is specified on the command line.

``` yaml $(tag) == '6.2' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/6.2/$(namespace)
```


### Tag: 6.3 and go

These settings apply only when `--tag=6.3 --go` is specified on the command line.

``` yaml $(tag) == '6.3' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/6.3/$(namespace)
```

### Tag: 6.4 and go

These settings apply only when `--tag=6.4 --go` is specified on the command line.

``` yaml $(tag) == '6.4' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/6.4/$(namespace)
```

### Tag: 6.5 and go

These settings apply only when `--tag=6.5 --go` is specified on the command line.

``` yaml $(tag) == '6.5' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/6.5/$(namespace)
```

### Tag: 7.0 and go

These settings apply only when `--tag=7.0 --go` is specified on the command line.

``` yaml $(tag) == '7.0' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/7.0/$(namespace)
```

### Tag: 7.2 and go

These settings apply only when `--tag=7.2 --go` is specified on the command line.

``` yaml $(tag) == '7.2' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/7.2/$(namespace)
```

### Tag: 8.0 and go

These settings apply only when `--tag=8.0 --go` is specified on the command line.

``` yaml $(tag) == '8.0' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/8.0/$(namespace)
```

### Tag: 8.2 and go

These settings apply only when `--tag=8.2 --go` is specified on the command line.

``` yaml $(tag) == '8.2' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/8.2/$(namespace)
```