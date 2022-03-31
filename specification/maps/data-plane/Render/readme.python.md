## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.maps.render
package-name: azure-maps-render
package-version: 2.1-preview
clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/maps/azure-maps-render/azure/maps/render/_generated
```
``` yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/maps/azure-maps-render/
```
