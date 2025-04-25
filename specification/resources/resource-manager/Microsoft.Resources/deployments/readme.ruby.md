
## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_deployments_deployments
package-version: "0.1.1"
azure-arm: true
```

### Tag: package-deployments-2025-04 and ruby

These settings apply only when `--tag=package-deployments-2025-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-deployments-2025-04' && $(ruby)
namespace: "Azure::Deployments::Deployments::Mgmt::V2025_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_deployments/lib
```
