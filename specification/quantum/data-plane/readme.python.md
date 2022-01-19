## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
python-mode: create
python:
  package-version: 0.0.0b1
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: azure.quantum._client
  package-name: azure-quantum-_client
  clear-output-folder: true
  no-namespace-folders: false
  add-credentials: true
  credential-scopes: ["https://quantum.microsoft.com/.default"]
  output-folder: $(python-sdks-folder)/quantum/azure-quantum
  basic-setup-py: true
```

```yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/quantum/azure-quantum/azure/quantum/_client
```

```yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/quantum/azure-quantum
```
