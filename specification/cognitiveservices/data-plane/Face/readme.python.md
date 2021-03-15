## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
license-header: MICROSOFT_MIT_NO_VERSION
add-credentials: true
payload-flattening-threshold: 2
namespace: azure.cognitiveservices.vision.face
package-name: azure-cognitiveservices-vision-face
clear-output-folder: false
use: "@microsoft.azure/autorest.python@~4.0.71" 
version: V2
multiapi: true
no-async: true
```
``` yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitiveservices-vision-face/azure/cognitiveservices/vision/face
keep-version-file: true
```
``` yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitives
```