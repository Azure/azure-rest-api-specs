## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python) && !$(track2)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.customproviders
  package-name: azure-mgmt-customproviders
  package-version: 2018-09-01-preview
  clear-output-folder: true
```
```yaml $(python) && $(track2)
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.customproviders
package-name: azure-mgmt-customproviders
package-version: 2018-09-01-preview
clear-output-folder: true
```

```yaml $(python) && $(python-mode) == 'create' && !$(track2)
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/customproviders/azure-mgmt-customproviders
```
``` yaml $(python) && $(python-mode) == 'update' && !$(track2)
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/customproviders/azure-mgmt-customproviders/azure/mgmt/customproviders
```

```yaml $(python) && $(python-mode) == 'create' && $(track2)
basic-setup-py: true
output-folder: $(python-sdks-folder)/customproviders/azure-mgmt-customproviders
```
``` yaml $(python) && $(python-mode) == 'update' && $(track2)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/customproviders/azure-mgmt-customproviders/azure/mgmt/customproviders
```
