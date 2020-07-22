## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml
add-credentials: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 1
package-name: azure-synapse
package-version: 0.1.0
clear-output-folder: true
credential-scopes: https://dev.azuresynapse.net/.default
batch:
  - package-spark: true
  - package-artifacts: true
  - package-access-control: true
```
``` yaml $(package-spark)
no-namespace-folders: true
namespace: azure.synapse.spark
<<<<<<< HEAD
output-folder: $(python-sdks-folder)/synapse/azure-synapse-spark/azure/synapse/spark
=======
output-folder: $(python-sdks-folder)/synapse/azure-synapse/azure/synapse/spark
>>>>>>> 4ea1e0abb0265a95f3f49494d2f0815b6be6d7d6
```
``` yaml $(package-artifacts)
no-namespace-folders: true
namespace: azure.synapse.artifacts
<<<<<<< HEAD
output-folder: $(python-sdks-folder)/synapse/azure-synapse-artifacts/azure/synapse/artifacts
=======
output-folder: $(python-sdks-folder)/synapse/azure-synapse/azure/synapse/artifacts
>>>>>>> 4ea1e0abb0265a95f3f49494d2f0815b6be6d7d6
```
``` yaml $(package-access-control)
no-namespace-folders: true
namespace: azure.synapse.accesscontrol
<<<<<<< HEAD
output-folder: $(python-sdks-folder)/synapse/azure-synapse-accesscontrol/azure/synapse/accesscontrol
=======
output-folder: $(python-sdks-folder)/synapse/azure-synapse/azure/synapse/accesscontrol
>>>>>>> 4ea1e0abb0265a95f3f49494d2f0815b6be6d7d6
```
