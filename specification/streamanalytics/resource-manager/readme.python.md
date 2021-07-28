## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.


``` yaml !$(track2)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.streamanalytics
  package-name: azure-mgmt-streamanalytics
  package-version: 0.1.0
  clear-output-folder: true
```

These settings apply only when `--track2` is specified on the command line.

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-streamanalytics
no-namespace-folders: true
```

``` yaml $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/streamanalytics/azure-mgmt-streamanalytics/azure/mgmt/streamanalytics
no-namespace-folders: true
output-folder: $(python-sdks-folder)/streamanalytics/azure-mgmt-streamanalytics/azure/mgmt/streamanalytics
```
``` yaml $(python-mode) == 'create'
python:
  package-version: 0.1.0
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/streamanalytics/azure-mgmt-streamanalytics
package-version: 0.1.0
basic-setup-py: true
output-folder: $(python-sdks-folder)/streamanalytics/azure-mgmt-streamanalytics
```
