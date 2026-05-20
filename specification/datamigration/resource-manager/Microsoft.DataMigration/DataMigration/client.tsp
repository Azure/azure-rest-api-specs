import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.DataMigration;

@@clientName(Microsoft.DataMigration,
  "DataMigrationManagementClient",
  "javascript,python"
);

@@clientName(ConnectToTargetSqlSqlDbSyncTaskProperties,
  "ConnectToTargetSQLDbSyncTaskProperties",
  "go"
);
@@clientName(ConnectToTargetSqlSqlDbSyncTaskInput,
  "ConnectToTargetSQLDbSyncTaskInput",
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

@@clientName(ConnectToTargetSqlSqlDbSyncTaskInput,
  "ConnectToTargetSqlDbSyncTaskInput",
  "python"
);
@@clientName(ConnectToTargetSqlSqlDbSyncTaskProperties,
  "ConnectToTargetSqlDbSyncTaskProperties",
  "python"
);

@@clientName(ConnectToTargetSqlSqlDbSyncTaskInput,
  "ConnectToTargetSqlDbSyncTaskInput",
  "java"
);
@@clientName(ConnectToTargetSqlSqlDbSyncTaskProperties,
  "ConnectToTargetSqlDbSyncTaskProperties",
  "java"
);
@@clientName(OracleOCIDriverInfo, "OracleOciDriverInfo", "java");
@@clientName(CheckOCIDriverTaskProperties,
  "CheckOciDriverTaskProperties",
  "java"
);
@@clientName(CheckOCIDriverTaskInput, "CheckOciDriverTaskInput", "java");
@@clientName(CheckOCIDriverTaskOutput, "CheckOciDriverTaskOutput", "java");
@@clientName(UploadOCIDriverTaskProperties,
  "UploadOciDriverTaskProperties",
  "java"
);
@@clientName(UploadOCIDriverTaskInput, "UploadOciDriverTaskInput", "java");
@@clientName(UploadOCIDriverTaskOutput, "UploadOciDriverTaskOutput", "java");
@@clientName(InstallOCIDriverTaskProperties,
  "InstallOciDriverTaskProperties",
  "java"
);
@@clientName(InstallOCIDriverTaskInput, "InstallOciDriverTaskInput", "java");
@@clientName(InstallOCIDriverTaskOutput, "InstallOciDriverTaskOutput", "java");

@@clientName(ConnectionInfo.userName, "username", "java");
@@clientName(FileShare.userName, "username", "java");
@@clientName(SqlConnectionInformation.userName, "username", "java");
@@clientName(MongoConnectionInformation.userName, "username", "java");
@@clientName(MongoDbConnectionInfo.enforceSSL, "enforceSsl", "java");
@@clientName(SqlBackupSetInfo.firstLSN, "firstLsn", "java");
@@clientName(SqlBackupSetInfo.lastLSN, "lastLsn", "java");
@@clientName(ResourceSkuCosts.meterID, "meterId", "java");
@@clientName(MigrateSyncCompleteCommandInput.commitTimeStamp,
  "commitTimestamp",
  "java"
);
