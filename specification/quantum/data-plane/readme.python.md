## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
python-mode: create
python:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: azure.quantum._client
  package-name: azure-quantum
  add-credentials: true
  credential-scopes: "https://quantum.microsoft.com/.default"
  clear-output-folder: true
  no-namespace-folders: false
```

```yaml $(python) && $(python-mode) == 'update'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/quantum/azure-quantum
```

```yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/quantum/azure-quantum
```

```yaml $(python) && $(python-mode) == 'cli'
python:
  package-version: 0.0.0.1
  no-namespace-folders: true
```

```yaml $(python) && $(python-mode) == 'pythonSdk'
python:
  no-namespace-folders: true
```
