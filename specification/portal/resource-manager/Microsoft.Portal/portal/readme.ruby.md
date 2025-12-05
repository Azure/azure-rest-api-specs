## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_portal
package-version: 2015-08-01-preview
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-01-01-preview
  - tag: package-2018-10-01-preview
  - tag: package-2015-08-01-preview
```

### Tag: package-2019-01-01-preview and ruby

These settings apply only when `--tag=package-2019-01-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2019-01-01-preview' && $(ruby)
namespace: Microsoft.Portal
output-folder: $(ruby-sdks-folder)/portal
```

### Tag: package-2018-10-01-preview and ruby

These settings apply only when `--tag=package-2018-10-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2018-10-01-preview' && $(ruby)
namespace: Microsoft.Portal
output-folder: $(ruby-sdks-folder)/portal
```

### Tag: package-2015-08-01-preview and ruby

These settings apply only when `--tag=package-2015-08-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2015-08-01-preview' && $(ruby)
namespace: Microsoft.Portal
output-folder: $(ruby-sdks-folder)/portal
```
