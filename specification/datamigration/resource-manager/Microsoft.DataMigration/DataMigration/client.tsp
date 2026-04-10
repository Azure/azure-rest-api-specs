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
@@clientName(DatabaseMigrationCosmosDbMongos.getForScope,
  "listForScope",
  "javascript"
);
@@clientName(DatabaseMigrationsMongoToCosmosDbvCoreMongo.getForScope,
  "listForScope",
  "javascript"
);
