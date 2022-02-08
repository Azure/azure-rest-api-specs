## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && $(track2)
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.datafactory
package-name: azure-mgmt-datafactory
package-version: 1.0.0
clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update' && $(track2)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/datafactory/azure-mgmt-datafactory/azure/mgmt/datafactory
```
``` yaml $(python) && $(python-mode) == 'create' && $(track2)
basic-setup-py: true
output-folder: $(python-sdks-folder)/datafactory/azure-mgmt-datafactory
```

``` yaml $(python) && $(track2)
modelerfour:
  lenient-model-deduplication: true
directive:
  - from: swagger-document
    where: $.definitions.JsonFormatFilePattern
    transform: >
        $['type'] = 'string';
  - from: swagger-document
    where: $.definitions.CompressionLevel
    transform: >
        $['type'] = 'string'; 
  - from: swagger-document
    where: $.definitions.DynamicsLinkedServiceTypeProperties.properties.servicePrincipalCredentialType
    transform: >
        $['type'] = 'string'; 
  - from: swagger-document
    where: $.definitions.ScriptAction.properties.roles
    transform: >
        $['type'] = 'string';
```
