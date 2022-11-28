# Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_scvmm
package-version: 2022-11-22-preview
azure-arm: true
```

## Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2022-11-22-preview
```

## Tag: package-2022-11-22-preview and ruby

These settings apply only when `--tag=package-2022-11-22-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-11-22-preview' && $(ruby)
namespace: Microsoft.SCVMM
output-folder: $(ruby-sdks-folder)/scvmm
```