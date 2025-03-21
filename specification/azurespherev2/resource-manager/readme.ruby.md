## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_azurespherev2
package-version: 2022-09-01-privatepreview
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2022-09-01-privatepreview
```

### Tag: package-2022-09-01-privatepreview and ruby

These settings apply only when `--tag=package-2022-09-01-privatepreview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-09-01-privatepreview' && $(ruby)
namespace: Microsoft.AzureSphereV2
output-folder: $(ruby-sdks-folder)/azurespherev2
```