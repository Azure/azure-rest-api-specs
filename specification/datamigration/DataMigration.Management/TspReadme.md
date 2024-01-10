

``` yaml

library-name: DataMigration
# default tag is a preview version
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/2f28b5026a4b44adefd0237087acb0c48cfe31a6/specification/datamigration/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


list-exception:
  - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{sqlDBInstanceName}/providers/Microsoft.DataMigration/databaseMigrations/{targetDBName}
  - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/providers/Microsoft.DataMigration/databaseMigrations/{targetDBName}
  - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SqlVirtualMachine/sqlVirtualMachines/{sqlVirtualMachineName}/providers/Microsoft.DataMigration/databaseMigrations/{targetDBName}

directive:
  - from: sqlmigration.json
    where: $.definitions
    transform: >
      $.DatabaseMigrationPropertiesSqlMi['x-ms-client-name'] = 'DatabaseMigrationSqlMIProperties';
      $.DatabaseMigrationPropertiesSqlVm['x-ms-client-name'] = 'DatabaseMigrationSqlVmProperties';
      $.DatabaseMigrationPropertiesSqlDb['x-ms-client-name'] = 'DatabaseMigrationSqlDBProperties';
```
