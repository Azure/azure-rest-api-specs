## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.healthbot
package-name: azure-mgmt-healthbot
package-version: 2020-10-20-preview
clear-output-folder: true
```

```yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/healthbot/azure-mgmt-healthbot/azure/mgmt/healthbot
```
