import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.DBforPostgreSQL;
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.DBforPostgreSQL, "PostgreSQLManagementClient", "python");
@@clientName(Microsoft.DBforPostgreSQL,
  "PostgreSQLManagementFlexibleServerClient",
  "javascript"
);
@@clientName(PostgresMajorVersion.`11`, "ELEVEN", "python,javascript");
@@clientName(PostgresMajorVersion.`12`, "TWELVE", "python,javascript");
@@clientName(PostgresMajorVersion.`13`, "THIRTEEN", "python,javascript");
@@clientName(PostgresMajorVersion.`14`, "FOURTEEN", "python,javascript");
@@clientName(PostgresMajorVersion.`15`, "FIFTEEN", "python,javascript");
@@clientName(PostgresMajorVersion.`16`, "SIXTEEN", "python,javascript");
@@clientName(PostgresMajorVersion.`17`, "SEVENTEEN", "python,javascript");
@@clientName(PostgresMajorVersion.`18`, "EIGHTEEN", "python,javascript");

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
@@clientName(RequestIdResponseHeader.requestId, "xMsRequestId", "java,go");

@@clientName(Microsoft.DBforPostgreSQL.PostgreSqlFlexibleServerHighAvailabilityMode,
  "HighAvailabilityMode",
  "java,go"
);
@@clientName(Microsoft.DBforPostgreSQL.HighAvailabilityMode,
  "SupportedHighAvailabilityMode",
  "java,go"
);
@@alternateType(Microsoft.DBforPostgreSQL.ServerSkuCapability.supportedHaMode,
  PostgreSqlFlexibleServerHighAvailabilityMode[],
  "java,go"
);

@@clientName(PostgresMajorVersion.`11`, "Eleven", "go");
@@clientName(PostgresMajorVersion.`12`, "Twelve", "go");
@@clientName(PostgresMajorVersion.`13`, "Thirteen", "go");
@@clientName(PostgresMajorVersion.`14`, "Fourteen", "go");
@@clientName(PostgresMajorVersion.`15`, "Fifteen", "go");
@@clientName(PostgresMajorVersion.`16`, "Sixteen", "go");
@@clientName(PostgresMajorVersion.`17`, "Seventeen", "go");
@@clientName(PostgresMajorVersion.`18`, "Eighteen", "go");
