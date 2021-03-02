## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml
  python-mode: create
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: azure.iot.deviceupdate
  package-name: azure-iot-deviceupdate
  package-version: 1.0.0b1
  clear-output-folder: true
  add-credentials: true
  credential-scopes: 6ee392c4-d339-4083-b04d-6b7947c6cf78/.default
```

```yaml $(python-mode) == 'create'
output-folder: $(python-sdks-folder)/deviceupdate/azure-iot-deviceupdate
```

```yaml $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/deviceupdate/azure-iot-deviceupdate/azure/iot/deviceupdate
```
