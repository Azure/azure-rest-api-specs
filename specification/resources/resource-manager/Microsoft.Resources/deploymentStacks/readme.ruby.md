
## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_deployments_deploymentstacks
package-version: "0.1.1"
azure-arm: true
```

### Tag: package-deployments-2024-03 and ruby

These settings apply only when `--tag=package-deployments-2024-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-deployments-2024-03' && $(ruby)
namespace: "Azure::Deployments::DeploymentStacks::Mgmt::V2024_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_deployments/lib
```
