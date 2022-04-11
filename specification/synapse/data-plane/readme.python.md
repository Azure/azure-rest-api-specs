## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
add-credentials: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 1
package-version: 0.1.0
clear-output-folder: true
credential-scopes: https://dev.azuresynapse.net/.default
batch:
  - package-artifacts: true
  - package-access-control: true
  - package-vnet: true
  - package-monitoring: true
```
``` yaml $(package-spark) && $(python)
no-namespace-folders: true
package-name: azure-synapse-spark
namespace: azure.synapse.spark
output-folder: $(python-sdks-folder)/synapse/azure-synapse-spark/azure/synapse/spark
```
``` yaml $(package-artifacts) && $(python)
no-namespace-folders: true
package-name: azure-synapse-artifacts
namespace: azure.synapse.artifacts
modelerfour:
  lenient-model-deduplication: true
output-folder: $(python-sdks-folder)/synapse/azure-synapse-artifacts/azure/synapse/artifacts
```
``` yaml $(package-access-control) && (python)
no-namespace-folders: true
package-name: azure-synapse-accesscontrol
namespace: azure.synapse.accesscontrol
output-folder: $(python-sdks-folder)/synapse/azure-synapse-accesscontrol/azure/synapse/accesscontrol
```

``` yaml $(package-vnet) && (python)
no-namespace-folders: true
package-name: azure-synapse-managedprivateendpoints
namespace: azure.synapse.managedprivateendpoints
output-folder: $(python-sdks-folder)/synapse/azure-synapse-managedprivateendpoints/azure/synapse/managedprivateendpoints
```

``` yaml $(package-monitoring) && $(python)
no-namespace-folders: true
package-name: azure-synapse-monitoring
namespace: azure.synapse.monitoring
output-folder: $(python-sdks-folder)/synapse/azure-synapse-monitoring/azure/synapse/monitoring
```
