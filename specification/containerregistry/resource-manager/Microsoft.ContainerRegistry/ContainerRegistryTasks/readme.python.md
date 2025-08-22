## Python

These settings apply only when `--python` is specified on the command line.


```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-containerregistrytasks
clear-output-folder: true
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
multiapi: true
default-api-version: "2019-04-01"
batch:
  - tag: package-2025-03-preview-only
  - tag: package-2019-06-preview-only
  - tag: package-2019-04-only
  - tag: package-2018-09-only
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistrytasks/
perform-load: false
```

### Tag: package-2025-03-preview-only and python

These settings apply only when `--tag=package-2025-03-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2025-03-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2025_03_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistrytasks/v2025_03_01_preview
```

### Tag: package-2019-06-preview-only and python

These settings apply only when `--tag=package-2019-06-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-06-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2019_06_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistrytasks/v2019_06_01_preview
```

### Tag: package-2019-04-only and python

These settings apply only when `--tag=package-2019-04-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-04-only' && $(python)
namespace: azure.mgmt.containerregistry.v2019_04_01
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistrytasks/v2019_04_01
```

### Tag: package-2018-09-only and python

These settings apply only when `--tag=package-2018-09-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-09-only' && $(python)
namespace: azure.mgmt.containerregistry.v2018_09_01
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistrytasks/v2018_09_01
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