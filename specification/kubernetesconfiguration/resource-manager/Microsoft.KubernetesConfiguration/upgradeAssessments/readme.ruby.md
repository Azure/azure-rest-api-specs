## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_kubernetesconfiguration_upgradeassessments
package-version: "0.1.0"
azure-arm: true
```

### Tag: package-2026-06-preview and ruby

These settings apply only when `--tag=package-2026-06-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2026-06-preview' && $(ruby)
namespace: "Azure::KubernetesConfiguration::UpgradeAssessments::Mgmt::V2026_06_15_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_kubernetesconfiguration/lib
```
