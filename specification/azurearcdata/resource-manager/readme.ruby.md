## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_azurearcdata
package-version: 2021-03-02
azure-arm: true
```

### Tag: package-2021-03-02 and ruby

These settings apply only when `--tag=package-2021-03-02 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-03-02' && $(ruby)
namespace: Microsoft.AzureArcData
output-folder: $(ruby-sdks-folder)/azurearcdata
```

### Tag: package-2021-03-02 and ruby

These settings apply only when `--tag=package-2021-03-02 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-03-02' && $(ruby)
namespace: Microsoft.AzureArcData
output-folder: $(ruby-sdks-folder)/azurearcdata
```
