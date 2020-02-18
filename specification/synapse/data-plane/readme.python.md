## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml
python-mode: create
add-credentials: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 1
namespace: azure.synapse
package-name: azure-synapse
package-version: 0.1.0
clear-output-folder: true
credential-scopes: https://dev.azuresynapse.net/.default
```
``` yaml $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/synapse/azure-synapse/azure/synapse
```
``` yaml $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/synapse/azure-synapse
```
