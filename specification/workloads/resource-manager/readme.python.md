## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
python:
    azure-arm: true
    license-header: MICROSOFT_MIT_NO_VERSION
    namespace: azure-mgmt-workloads
    package-name: azure-mgmt-workloads
    package-version: 1.0.0b1
    clear-output-folder: true
```

``` yaml $(python-mode) == 'update' && $(python)
python:
    no-namespace-folders: true
    output-folder: $(python-sdks-folder)/workloads/azure-mgmt-workloads/azure/mgmt/workloads
```

``` yaml $(python-mode) == 'create' && $(python)
python:
    basic-setup-py: true
    output-folder: $(python-sdks-folder)/workloads/azure-mgmt-workloads
```