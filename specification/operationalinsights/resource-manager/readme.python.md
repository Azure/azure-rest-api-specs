## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && !$(track2)
directive:
    - from: swagger-document
      where: $.info
      transform: >
          $.title = 'LogAnalyticsManagementClient';
          $.description = 'The Log Analytics Client.';
          return $;
         
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.loganalytics
  package-name: azure-mgmt-loganalytics
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update' && !$(track2)
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/loganalytics/azure-mgmt-loganalytics/azure/mgmt/loganalytics
```
``` yaml $(python) && $(python-mode) == 'create'  && !$(track2)
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/loganalytics/azure-mgmt-loganalytics
```