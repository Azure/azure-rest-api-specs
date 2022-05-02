## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(track2)
python-mode: create
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.iot.deviceupdate
package-name: azure-iot-deviceupdate
package-version: 1.1.0b1
clear-output-folder: true
add-credentials: true
credential-scopes: https://api.adu.microsoft.com/.default
```

``` yaml $(python-mode) == 'create' && $(track2)
basic-setup-py: true
output-folder: $(python-sdks-folder)/deviceupdate/azure-iot-deviceupdate
```

``` yaml $(python-mode) == 'update' && $(track2)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/deviceupdate/azure-iot-deviceupdate/azure/iot/deviceupdate
```
