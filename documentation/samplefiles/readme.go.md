## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: [[ServiceName]]
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-[[Version]][[-ReleaseState]]
```

### Tag: package-[[Version]][[-ReleaseState]] and go

These settings apply only when `--tag=package-[[Version]][[-ReleaseState]] --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-[[Version]][[-ReleaseState]]' && $(go)
output-folder: $(go-sdk-folder)/services[[/ReleaseState]]/$(namespace)/mgmt/[[Version]]/$(namespace)
```
