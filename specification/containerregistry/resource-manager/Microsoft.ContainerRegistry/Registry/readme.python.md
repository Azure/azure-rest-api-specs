## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

### Tag: package-2025-11-python

``` yaml $(tag) == 'package-2025-11-python'
input-file:
  - stable/2025-11-01/containerregistry.json
  - ../RegistryTasks/preview/2025-03-01-preview/containerregistry_build.json
```


``` yaml $(python)
title: ContainerRegistryManagementClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-containerregistry
namespace: azure.mgmt.containerregistry
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry
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