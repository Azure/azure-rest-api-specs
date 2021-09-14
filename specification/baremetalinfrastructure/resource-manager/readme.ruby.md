## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_baremetalinfrastructure
package-version: 2021-08-09
azure-arm: true
```

### Tag: package-2021-08-09 and ruby

These settings apply only when `--tag=package-2021-08-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-08-09' && $(ruby)
namespace: Microsoft.BareMetalInfrastructure
output-folder: $(ruby-sdks-folder)/baremetalinfrastructure
```

### Tag: package-2020-08-06-preview and ruby

These settings apply only when `--tag=package-2020-08-06-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-08-06-preview' && $(ruby)
namespace: Microsoft.BareMetalInfrastructure
output-folder: $(ruby-sdks-folder)/baremetalinfrastructure
```