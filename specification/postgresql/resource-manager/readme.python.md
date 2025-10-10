## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
title: PostgreSQLManagementClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
no-namespace-folders: true
clear-output-folder: true
package-version: 1.1.0b2
package-name: azure-mgmt-postgresqlflexibleservers
namespace: azure.mgmt.postgresqlflexibleservers
output-folder: $(python-sdks-folder)/postgresqlflexibleservers/azure-mgmt-postgresqlflexibleservers/azure/mgmt/postgresqlflexibleservers
```

### Tag: package-2020-01-01 and python

These settings apply only when `--tag=package-2020-01-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-01' && $(python)
package-name: azure-mgmt-rdbms
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
