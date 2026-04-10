import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.DataMigration;

@@clientName(Microsoft.DataMigration,
  "DataMigrationManagementClient",
  "javascript"
);

@@clientName(ConnectToTargetSqlSqlDbSyncTaskProperties,
  "ConnectToTargetSQLDbSyncTaskProperties",
  "go"
);
@@alternateType(DatabaseMigrationProperties.kind, ResourceType, "go");
@@alternateType(DatabaseMigrationPropertiesSqlDb.kind, ResourceType, "go");
@@alternateType(DatabaseMigrationPropertiesSqlMi.kind, ResourceType, "go");
@@alternateType(DatabaseMigrationPropertiesSqlVm.kind, ResourceType, "go");
