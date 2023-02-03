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

### Tag: package-2021-06-30-preview
These settings apply only when `--tag=package-2021-06-30-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-06-30-preview' && $(python)
python:
  namespace: Azure.DigitalTwins.Core
  package-name: digitaltwins
  package-version: 2021-06-30-preview
  output-folder: $(python-sdks-folder)/digitaltwins/2021-06-30-preview
```

### Tag: package-2020-10-31
These settings apply only when `--tag=package-2020-10-31` is specified on the command line.

```yaml $(tag) == 'package-2020-10-31' && $(python)
python:
  namespace: Azure.DigitalTwins.Core
  package-name: digitaltwins
  package-version: 2020-10-31
  output-folder: $(python-sdks-folder)/digitaltwins/2020-10-31
```

### Tag: package-2020-05-31-preview
These settings apply only when `--tag=package-2020-05-31-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-05-31-preview' && $(python)
python:
  namespace: Azure.DigitalTwins.Core
  package-name: digitaltwins
  package-version: 2020-05-31-preview
  output-folder: $(python-sdks-folder)/digitaltwins/2020-05-31-preview
```

```yaml $(python)
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/digitaltwins
```
