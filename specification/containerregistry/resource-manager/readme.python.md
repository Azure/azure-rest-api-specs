## Python

These settings apply only when `--python` is specified on the command line.


```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-containerregistry
clear-output-folder: true
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
multiapi: true
default-api-version: "2025-04-01"
batch:
  - tag: package-2025-05-preview-only
  - tag: package-2025-04-only
  - tag: package-2025-03-preview-only
  - tag: package-2024-11-preview-only
  - tag: package-2023-11-preview-only
  - tag: package-2023-01-preview-only
  - tag: package-2022-02-preview-only
  - tag: package-2021-08-preview-only
  - tag: package-2020-11-preview-only
  - tag: package-2019-06-preview-only
  - tag: package-2019-05-only
  - tag: package-2019-05-preview-only
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/
perform-load: false
```

### Tag: package-2025-05-preview-only and python

These settings apply only when `--tag=package-2025-05-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2025-05-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2025_05_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2025_05_01_preview
```

### Tag: package-2025-04-only and python

These settings apply only when `--tag=package-2025-04-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2025-04-only' && $(python)
namespace: azure.mgmt.containerregistry.v2025_04_01
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2025_04_01
```

### Tag: package-2025-03-preview-only and python

These settings apply only when `--tag=package-2025-03-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2025-03-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2025_03_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2025_03_01_preview
```

### Tag: package-2024-11-preview-only and python

These settings apply only when `--tag=package-2024-11-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-11-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2024_11_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2024_11_01_preview
```

### Tag: package-2023-11-preview-only and python

These settings apply only when `--tag=package-2023-11-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-11-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2023_11_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2023_11_01_preview
```

### Tag: package-2023-01-preview-only and python

These settings apply only when `--tag=package-2023-01-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-01-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2023_01_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2023_01_01_preview
```

### Tag: package-2022-02-preview-only and python

These settings apply only when `--tag=package-2022-02-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-02-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2022_02_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2022_02_01_preview
```

### Tag: package-2021-08-preview-only and python

These settings apply only when `--tag=package-2021-08-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-08-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2021_08_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2021_08_01_preview
```

### Tag: package-2020-11-preview-only and python

These settings apply only when `--tag=package-2020-11-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-11-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2020_11_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2020_11_01_preview
```

### Tag: package-2019-06-preview-only and python

These settings apply only when `--tag=package-2019-06-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-06-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2019_06_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_06_01_preview
```

### Tag: package-2019-05-only and python

These settings apply only when `--tag=package-2019-05-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-05-only' && $(python)
namespace: azure.mgmt.containerregistry.v2019_05_01
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_05_01
```

### Tag: package-2019-05-preview-only and python

These settings apply only when `--tag=package-2019-05-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-05-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2019_05_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_05_01_preview
```

``` yaml $(python)
directive:
  - from: swagger-document
    where: $.definitions.BuildStepProperties
    transform: >
        $['required'] = ['type'];
  - from: swagger-document
    where: $.definitions.BuildStepPropertiesUpdateParameters
    transform: >
        $['required'] = ['type'];
  - from: swagger-document
    where: $.definitions.QueueBuildRequest
    transform: >
        $['required'] = ['type']; 
  - from: swagger-document
    where: $.definitions.RunRequest
    transform: >
        $['required'] = ['type'];
  - from: swagger-document
    where: $.definitions.TaskStepProperties
    transform: >
        $['required'] = ['type']; 
  - from: swagger-document
    where: $.definitions.TaskStepUpdateParameters
    transform: >
        $['required'] = ['type'];
```

``` yaml $(python)
directive:
  - from: swagger-document
    where: $.definitions
    transform: >
      $.LoginServerProperties.properties.tls = {
          "$ref": "#/definitions/TlsProperties",
          "description": "The TLS properties of the connected registry login server.",
          "readOnly": true
        };
      $.TlsProperties.properties.certificate = {
          "$ref": "#/definitions/TlsCertificateProperties",
          "description": "The certificate used to configure HTTPS for the login server.",
          "readOnly": true
        };
```