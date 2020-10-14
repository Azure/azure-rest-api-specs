## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_adp
package-version: 2020-07-01-preview
azure-arm: true
```

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2020-07-01-preview
```


### Tag: package-2020-07-01-preview and ruby

These settings apply only when `--tag=package-2020-07-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-07-01-preview' && $(ruby)
namespace: Azure::AutonomousDevelopmentPlatform::Mgmt::V2020_07_01_preview
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_adp/lib
```
