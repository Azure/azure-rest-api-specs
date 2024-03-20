## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-rdbms
no-namespace-folders: true
package-version: 1.0.0b1
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
clear-output-folder: true
batch:
  - tag: package-flexibleserver-2023-12-01-preview
  - tag: package-2020-01-01
```

### Tag: package-flexibleserver-2023-12-01-preview and python

These settings apply only when `--tag=package-flexibleserver-2023-12-01-preview --python` is specified on the command line.
Please also specify `--python-sdk-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-flexibleserver-2023-12-01-preview' && $(python)
namespace: azure.mgmt.rdbms.postgresql_flexibleservers
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql_flexibleservers
```

### Tag: package-2020-01-01 and python

These settings apply only when `--tag=package-2020-01-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-01' && $(python)
namespace: azure.mgmt.rdbms.postgresql
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
```

```yaml $(python)
directive:
  - from: swagger-document
    where: $.definitions.ServerProperties.properties.sourceServerResourceId
    transform: >
        $['format'] = 'string';

  - from: swagger-document
    where: $.definitions.Network.properties.delegatedSubnetResourceId
    transform: >
        $['format'] = 'string';

  - from: swagger-document
    where: $.definitions.Network.properties.privateDnsZoneArmResourceId
    transform: >
        $['format'] = 'string';
```
