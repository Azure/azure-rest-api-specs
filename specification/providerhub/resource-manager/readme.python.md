## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.providerhub
package-name: azure-mgmt-providerhub
package-version: 2020-11-20
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/providerhub/azure-mgmt-providerhub/azure/mgmt/providerhub
```

``` yaml $(python)
modelerfour:
    lenient-model-deduplication: true
```
