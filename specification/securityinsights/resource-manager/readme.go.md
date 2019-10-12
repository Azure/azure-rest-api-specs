## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: securityinsight
  clear-output-folder: true
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-composite-v1
```

### Tag: package-composite-v1 and go

These settings apply only when `--tag=package-composite-v1 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-composite-v1' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-08-01-preview/$(namespace)
```
