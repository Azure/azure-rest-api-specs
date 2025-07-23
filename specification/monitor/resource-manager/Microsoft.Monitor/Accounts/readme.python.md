## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.monitor
package-name: azure-mgmt-monitor
package-version: 1.0.0b1
clear-output-folder: true
lenient-model-deduplication: true
no-namespace-folders: true
```
