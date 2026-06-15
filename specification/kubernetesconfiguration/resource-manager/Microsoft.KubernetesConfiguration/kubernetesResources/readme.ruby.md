## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_kubernetesconfiguration_kubernetesresources
package-version: "0.1.0"
azure-arm: true
```

### Tag: package-preview-2026-07 and ruby

These settings apply only when `--tag=package-preview-2026-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-preview-2026-07' && $(ruby)
namespace: "Azure::KubernetesConfiguration::KubernetesResources::Mgmt::V2026_07_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```
