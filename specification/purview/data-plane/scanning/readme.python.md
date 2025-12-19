## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml
add-credential: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.purview.scanning
package-name: azure-purview-scanning
clear-output-folder: truefr
package-version: 1.0.0b1
basic-setup-py: true
output-folder: $(python-sdks-folder)/purview/azure-purview-scanning/
credential-scopes: https://purview.azure.net/.default
low-level-client: true
```
