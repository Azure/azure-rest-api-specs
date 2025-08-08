import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DBforMySQL;

@@clientName(Microsoft.DBforMySQL,
  "MySQLManagementFlexibleServerClient",
  "javascript"
);

@@clientName(ServerVersion.`5.7`, "Five7", "javascript");
@@clientName(ServerVersion.`8.0.21`, "Eight021", "javascript");
