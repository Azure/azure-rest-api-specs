## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: digitaltwins
  clear-output-folder: true
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-06-30-preview
  - tag: package-2020-10-31
  - tag: package-2020-05-31-preview
```


### Tag: package-2021-06-30-preview and go

These settings apply only when `--tag=package-2021-06-30-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-06-30-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/2021-06-30-preview/$(namespace)
```

### Tag: package-2020-10-31 and go

These settings apply only when `--tag=package-2020-10-31 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-10-31' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/2020-10-31/$(namespace)
```

### Tag: package-2020-05-31-preview and go

These settings apply only when `--tag=package-2020-05-31-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-05-31-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/2020-05-31-preview/$(namespace)
```
