## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
python-mode: create
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.devcenter
package-name: azure-devcenter
package-version: 1.0-preview
clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/azure-devcenter/
```