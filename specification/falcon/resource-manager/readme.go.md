## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: falcon
  output-folder: $(go-sdks-folder)/services/preview/$(namespace)/mgmt/2024-10-14-preview/$(namespace)
  clear-output-folder: true
```

### Tag: package-preview-2024-10-14-preview

These settings apply only when `--tag=package-preview-2024-10-14-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-10-14-preview' && $(go)
output-folder: $(go-sdks-folder)/services/preview/$(namespace)/mgmt/2024-10-14-preview/$(namespace)
```

### Tag: package-2020-09-02-preview

These settings apply only when `--tag=package-2020-09-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-09-02-preview' && $(go)
output-folder: $(go-sdks-folder)/services/preview/$(namespace)/mgmt/2020-09-02-preview/$(namespace)
```

### Tag: package-2020-01-20-preview and go

These settings apply only when `--tag=package-2020-01-20-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-01-20-preview' && $(go)
output-folder: $(go-sdks-folder)/services/preview/$(namespace)/mgmt/2020-01-20-preview/$(namespace)
```
