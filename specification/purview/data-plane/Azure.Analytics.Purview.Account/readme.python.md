## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-purview-account
package-version: 1.0.0b1
clear-output-folder: true
no-namespace-folders: true
basic-setup-py: true
output-folder: $(python-sdks-folder)/purview/azure-purview-account/
low-level-client: true
add-credential: true
credential-scopes: https://purview.azure.net/.default
```
