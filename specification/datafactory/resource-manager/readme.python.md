## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && !$(track2)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.datafactory
  package-name: azure-mgmt-datafactory
  package-version: 1.0.0
  clear-output-folder: true
```

``` yaml $(python) && $(track2)
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.datafactory
package-name: azure-mgmt-datafactory
package-version: 1.0.0b1
clear-output-folder: true

directive:
  - from: Trigger.json
    where: $.definitions.BlobEventTypes.items
    transform: >
      return {
        "type": "string",
        "enum": [
          "Microsoft.Storage.BlobCreated",
          "Microsoft.Storage.BlobDeleted"
        ],
        "x-ms-enum": {
          "name": "BlobEventTypesEnum",
          "modelAsString": true
        }
      }
```

``` yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/datafactory/azure-mgmt-datafactory/azure/mgmt/datafactory
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/datafactory/azure-mgmt-datafactory/azure/mgmt/datafactory
```
``` yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/datafactory/azure-mgmt-datafactory
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/datafactory/azure-mgmt-datafactory
```
