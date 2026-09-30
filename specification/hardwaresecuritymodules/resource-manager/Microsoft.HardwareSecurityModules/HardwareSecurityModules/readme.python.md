## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
title: HardwareSecurityModulesMgmtClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.hardwaresecuritymodules
package-name: azure-mgmt-hardwaresecuritymodules
package-version: 1.0.0b2
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/hardwaresecuritymodules/azure-mgmt-hardwaresecuritymodules/azure/mgmt/hardwaresecuritymodules
```
