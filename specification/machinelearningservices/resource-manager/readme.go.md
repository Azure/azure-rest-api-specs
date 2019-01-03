## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: services
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-11
```

### Tag: package-2018-11 and go

These settings apply only when `--tag=package-2018-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2018-11' && $(go)
output-folder: $(go-sdk-folder)/services/stable/machinelearning/mgmt/2018-11-19/$(namespace)
```

### Tag: package-2018-03-preview and go

These settings apply only when `--tag=package-2018-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2018-03-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/machinelearning/mgmt/2018-03-01-preview/$(namespace)
```
