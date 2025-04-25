
## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_deployments_deploymentscripts
package-version: "0.1.1"
azure-arm: true
```

### Tag: package-deployments-2023-08 and ruby

These settings apply only when `--tag=package-deployments-2023-08 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-deployments-2023-08' && $(ruby)
namespace: "Azure::Deployments::DeploymentScripts::Mgmt::V2023_08_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_deployments/lib
```
