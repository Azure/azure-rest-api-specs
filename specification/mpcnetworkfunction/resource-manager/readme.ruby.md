## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_mpcnetworkfunction
package-version: 2023-10-15
azure-arm: true
```

### Tag: package-2023-10-15 and ruby

These settings apply only when `--tag=package-2023-10-15 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2023-10-15' && $(ruby)
namespace: mpcnetworkfunction
output-folder: $(ruby-sdks-folder)/mpcnetworkfunction
```

### Tag: package-2023-05-15-preview and ruby

These settings apply only when `--tag=package-2023-05-15-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2023-05-15-preview' && $(ruby)
namespace: mpcnetworkfunction
output-folder: $(ruby-sdks-folder)/mpcnetworkfunction
```
