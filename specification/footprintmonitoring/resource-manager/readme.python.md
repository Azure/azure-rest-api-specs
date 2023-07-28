## Python

```yaml $(python)
python:
    azure-arm: true
    license-header: MICROSOFT_MIT_NO_VERSION
    namespace: azure.mgmt.footprintmonitoring
    package-name: azure-mgmt-footprintmonitoring
    payload-flattening-threshold: 2
    package-version: 0.1.0
    clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'update'
python:
    no-namespace-folders: true
    output-folder: $(python-sdks-folder)/footprintmonitoring/azure-mgmt-footprintmonitoring/azure/mgmt/footprintmonitoring
```
``` yaml $(python) && $(python-mode) == 'create'
python:
    basic-setup-py: true
    output-folder: $(python-sdks-folder)/footprintmonitoring/azure-mgmt-footprintmonitoring
```
