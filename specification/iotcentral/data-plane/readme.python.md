## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  no-namespace-folders: true
  clear-output-folder: true
```

### Tag: package-1.1-preview
These settings apply only when `--tag=package-1.1-preview` is specified on the command line.

```yaml $(tag) == 'package-1.1-preview'
python:
  namespace: Microsoft.Azure.IotCentral.Preview
  package-name: iotcentral
  package-version: 1.1-preview
  output-folder: $(python-sdks-folder)/iotcentral/1.1-preview
```

### Tag: package-2021-04-30-preview
These settings apply only when `--tag=package-2021-04-30-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-04-30-preview'
python:
  namespace: Microsoft.Azure.IotCentral.Preview
  package-name: iotcentral
  package-version: 2021-04-30-preview
  output-folder: $(python-sdks-folder)/iotcentral/preview
```

### Tag: package-1.0
These settings apply only when `--tag=package-1.0` is specified on the command line.

```yaml $(tag) == 'package-1.0'
python:
  namespace: Microsoft.Azure.IotCentral.Stable
  package-name: iotcentral
  package-version: 1.0
  output-folder: $(python-sdks-folder)/iotcentral/1.0
```