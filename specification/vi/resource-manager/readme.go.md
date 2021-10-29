## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: vi
  clear-output-folder: true
```
### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-10-18-preview
  - tag: package-2021-10-27-preview

```
please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/$(version)/$(namespace)
```
