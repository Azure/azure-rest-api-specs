import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.DBforPostgreSQL;
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.DBforPostgreSQL,
  "PostgreSQLManagementClient",
  "python,javascript"
);
@@clientName(PostgresMajorVersion.`11`, "ELEVEN", "python");
@@clientName(PostgresMajorVersion.`12`, "TWELVE", "python");
@@clientName(PostgresMajorVersion.`13`, "THIRTEEN", "python");
@@clientName(PostgresMajorVersion.`14`, "FOURTEEN", "python");
@@clientName(PostgresMajorVersion.`15`, "FIFTEEN", "python");
@@clientName(PostgresMajorVersion.`16`, "SIXTEEN", "python");
@@clientName(PostgresMajorVersion.`17`, "SEVENTEEN", "python");
@@clientName(PostgresMajorVersion.`18`, "EIGHTEEN", "python");

@@clientName(Microsoft.DBforPostgreSQL.ServerProperties.pointInTimeUTC,
  "pointInTimeUtc",
  "java"
);
@@clientName(Microsoft.DBforPostgreSQL.DataEncryption.primaryKeyURI,
  "primaryKeyUri",
  "java"
);
@@clientName(Microsoft.DBforPostgreSQL.DataEncryption.geoBackupKeyURI,
  "geoBackupKeyUri",
  "java"
);
@@clientName(RequestIdResponseHeader.requestId, "xMsRequestId", "java");
