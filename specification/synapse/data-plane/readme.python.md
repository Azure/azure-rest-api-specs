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
  - package-vnet: true
  - package-monitoring: true
```
``` yaml $(package-spark)
no-namespace-folders: true
namespace: azure.synapse.spark
output-folder: $(python-sdks-folder)/synapse/azure-synapse-spark/azure/synapse/spark
```
``` yaml $(package-artifacts)
no-namespace-folders: true
namespace: azure.synapse.artifacts
modelerfour:
  lenient-model-deduplication: true
output-folder: $(python-sdks-folder)/synapse/azure-synapse-artifacts/azure/synapse/artifacts
```
``` yaml $(package-access-control)
no-namespace-folders: true
namespace: azure.synapse.accesscontrol
output-folder: $(python-sdks-folder)/synapse/azure-synapse-accesscontrol/azure/synapse/accesscontrol
```

``` yaml $(package-vnet)
no-namespace-folders: true
namespace: azure.synapse.managedprivateendpoints
output-folder: $(python-sdks-folder)/synapse/azure-synapse-managedprivateendpoints/azure/synapse/managedprivateendpoints
```

``` yaml $(package-monitoring)
no-namespace-folders: true
namespace: azure.synapse.monitoring
output-folder: $(python-sdks-folder)/synapse/azure-synapse-monitoring/azure/synapse/monitoring
```

### LRO spark methods
``` yaml $(package-spark)
directive:
    from: swagger-document
    where: $["paths"]["/batches"].post
    transform: >
        $["x-ms-long-running-operation"] = true;
        $["x-python-custom-poller-sync"] = "my.library.CustomPoller";
        $["x-python-custom-poller-async"] = "my.library.aio.AsyncCustomPoller"
```