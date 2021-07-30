## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.managementgroups
package-name: azure-mgmt-managementgroups
package-version: 2019-05-01
clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update' && $(track2)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/managementgroups/azure-mgmt-managementgroups/azure/mgmt/managementgroups
```
``` yaml $(python) && $(python-mode) == 'create' && $(track2)
basic-setup-py: true
output-folder: $(python-sdks-folder)/managementgroups/azure-mgmt-managementgroups
```
