## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python) && !$(track2)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: azure.mgmt.logic
  package-name: azure-mgmt-logic
  package-version: 2019-05-01
  clear-output-folder: true
```
```yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.logic
package-name: azure-mgmt-logic
package-version: 2019-05-01
clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/logic/azure-mgmt-logic/azure/mgmt/logic
no-namespace-folders: true
output-folder: $(python-sdks-folder)/logic/azure-mgmt-logic/azure/mgmt/logic
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/logic/azure-mgmt-logic
basic-setup-py: true
output-folder: $(python-sdks-folder)/logic/azure-mgmt-logic
```