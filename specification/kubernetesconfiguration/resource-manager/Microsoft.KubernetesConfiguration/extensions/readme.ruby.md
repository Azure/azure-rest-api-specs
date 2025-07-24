## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_kubernetesconfiguration_extensions
package-version: "0.1.1"
azure-arm: true
```

### Tag: package-2024-11 and ruby

These settings apply only when `--tag=package-2024-11 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2024-11' && $(ruby)
namespace: "Azure::KubernetesConfiguration::Extensions::Mgmt::V2024_11_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```
