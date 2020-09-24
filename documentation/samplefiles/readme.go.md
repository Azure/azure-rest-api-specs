## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: [[ServiceName]]
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-07
```

### Tag: package-[[Version]]-[[ReleaseState]] and go

These settings apply only when `--tag=package-[[Version]] --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-[[Version]]-[[ReleaseState]]' && $(go)
namespace: [[ResourceProviderName]]
output-folder: $(go-sdk-folder)/services/[[ReleaseState]]/$(namespace)/mgmt/[[Version]]-[[ReleaseState]]/$(namespace)
```
