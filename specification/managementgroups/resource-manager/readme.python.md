## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python) 
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.managementgroups
package-name: azure-mgmt-managementgroups
package-version: 2019-05-01
clear-output-folder: true
```
``` yaml $(python) 
no-namespace-folders: true
output-folder: $(python-sdks-folder)/managementgroups/azure-mgmt-managementgroups/azure/mgmt/managementgroups
```
