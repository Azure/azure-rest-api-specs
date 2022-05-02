## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.maps.traffic
package-name: azure-maps-traffic
package-version: 1.0-preview
clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/maps/azure-maps-traffic/azure/maps/traffic/_generated
```
``` yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/maps/azure-maps-traffic/
```
