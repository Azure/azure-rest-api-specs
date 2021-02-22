## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_adp
package-version: 2021-02-01-preview
azure-arm: true
```

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: 2020-07-01-preview
  - tag: 2021-02-01-preview
```

```yaml $(tag) == '2020-07-01-preview'
rubytag: 2020_07_01_preview
```

```yaml $(tag) == '2021-02-01-preview'
rubytag: 2021_02_01_preview
```

Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(ruby)
namespace: Azure::AutonomousDevelopmentPlatform::Mgmt::V$(rubytag)
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_adp/lib
```
