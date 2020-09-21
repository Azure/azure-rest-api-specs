## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2019-12-01
  - tag: package-2020-07-01-preview
  # add every tag listed below
```

### Tag: package-2019-12-01 and go

These settings apply only when `--tag=package-2019-12-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2019-12-01' && $(go)
# NOTE: a stable tag must not contain any preview swagger files included
# NOTE: go namespace can only consist of lower case letters, numbers and underscores
namespace: yourservicename
# NOTE: for special cases, you can hard code the namespace in the output-folder
# NOTE: the output-folder of a stable tag must not be under the preview subdirectory
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-12-01/$(namespace)
```

### Tag: package-2020-07-01-preview and go

These settings apply only when `--tag=package-2020-07-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-07-01-preview' && $(go)
# NOTE: a preview tag must not contain at least one preview swagger file included
# NOTE: go namespace can only consist of lower case letters, numbers and underscores
namespace: yourservicename
# NOTE: a preview api-version must be under the preview sub-directory 
# NOTE: the output-folder of a preview tag must be under the preview subdirectory
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-07-01-preview/$(namespace)
```
