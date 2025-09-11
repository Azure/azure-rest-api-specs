## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 2
package-name: azure-mgmt-softwareplan
namespace: azure.mgmt.softwareplan
package-version: 1.0.0b1
clear-output-folder: true
```

```yaml $(python)
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/softwareplan/azure-mgmt-softwareplan/azure/mgmt/softwareplan
```
