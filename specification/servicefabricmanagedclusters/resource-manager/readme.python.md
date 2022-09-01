## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-servicefabricmanagedclusters
namespace: azure.mgmt.servicefabricmanagedclusters
package-version: 0.1.0
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/servicefabricmanagedclusters/azure-mgmt-servicefabricmanagedclusters/azure/mgmt/servicefabricmanagedclusters
```