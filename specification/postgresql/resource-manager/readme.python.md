## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
no-namespace-folders: true
package-name: azure-mgmt-rdbms
package-version: 10.1.1
clear-output-folder: true
```

```yaml $(python)
batch:
  - tag: package-flexibleserver-2021-06-01
  - tag: package-2020-01-01
```

### Tag: package-flexibleserver-2021-06-01 and python

These settings apply only when `--tag=package-flexibleserver-2021-06-01 --python` is specified on the command line.
Please also specify `--python-sdk-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-flexibleserver-2021-06-01' && $(python)
title: PostgreSQLManagementClient
namespace: azure.mgmt.rdbms.postgresql_flexibleservers
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql_flexibleservers
```

### Tag: package-2020-01-01 and python

These settings apply only when `--tag=package-2020-01-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-01' && $(python)
title: PostgreSQLManagementClient
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