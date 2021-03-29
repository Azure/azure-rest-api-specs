## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && $(track2)
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.cdn
package-name: azure-mgmt-cdn
package-version: 2.0.0
clear-output-folder: true
modelerfour: 
  lenient-model-deduplication: true
directive:
  - from: swagger-document
    where: $.definitions.DeliveryRuleAction.properties.name
    transform: >
      $['x-ms-enum'] = {
        "name": "DeliveryRuleActionEnum",
        "modelAsString": true
      };
```
``` yaml $(python) && $(python-mode) == 'update' && $(track2)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/cdn/azure-mgmt-cdn/azure/mgmt/cdn
```
``` yaml $(python) && $(python-mode) == 'create' && $(track2)
basic-setup-py: true
output-folder: $(python-sdks-folder)/cdn/azure-mgmt-cdn
```
