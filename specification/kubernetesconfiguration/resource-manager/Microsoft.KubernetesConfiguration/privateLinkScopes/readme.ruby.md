## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_kubernetesconfiguration_privatelinkscopes
package-version: "0.1.1"
azure-arm: true
```

### Tag: package-preview-2024-11 and ruby

These settings apply only when `--tag=package-preview-2024-11 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-preview-2024-11' && $(ruby)
namespace: "Azure::KubernetesConfiguration::PrivateLinkScopes::Mgmt::V2024_04_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```
