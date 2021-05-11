## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: mutestbase
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-12-16-preview[[-ReleaseState]]
```

### Tag: package-2020-12-16-preview[[-ReleaseState]] and go

These settings apply only when `--tag=package-2020-12-16-preview[[-ReleaseState]] --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-12-16-preview[[-ReleaseState]]' && $(go)
output-folder: $(go-sdk-folder)/services[[/ReleaseState]]/$(namespace)/mgmt/2020-12-16-preview/$(namespace)
```
