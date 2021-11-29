## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python) && $(track2)
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.redisenterprise
package-name: azure-mgmt-redisenterprise
package-version: 2.0.0
clear-output-folder: true
```

```yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/redisenterprise/azure-mgmt-redisenterprise/azure/mgmt/redisenterprise
```
```yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/redisenterprise/azure-mgmt-redisenterprise
```
