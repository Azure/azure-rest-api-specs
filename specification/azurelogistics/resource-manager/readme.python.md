## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && !$(track2)
python: 
    azure-arm: true
    license-header: MICROSOFT_MIT_NO_VERSION
    payload-flattening-threshold: 2
    namespace: azure.mgmt.logistics
    package-name: azure-mgmt-logistics
    clear-output-folder: true
    package-version: 1.0.0b1
```

``` yaml $(python-mode) == 'update' && !$(track2)
python:
    no-namespace-folders: true
    output-folder: $(python-sdks-folder)/logistics/azure-mgmt-logistics/azure/mgmt/logistics
```

``` yaml $(python-mode) == 'create' && !$(track2)
python:
    basic-setup-py: true
    output-folder: $(python-sdks-folder)/logistics/azure-mgmt-logistics
    package-version: 1.0.0b1
```

``` yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-logistics
namespace: azure.mgmt.logistics
package-version: 1.0.0b1
```

``` yaml $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/logistics/azure-mgmt-logistics/azure/mgmt/logistics
```

``` yaml $(python-mode) == 'create' && $(track2)
package-version: 1.0.0b1
basic-setup-py: true
output-folder: $(python-sdks-folder)/logistics/azure-mgmt-logistics
```
