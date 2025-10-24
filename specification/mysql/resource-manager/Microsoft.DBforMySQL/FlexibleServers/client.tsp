import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DBforMySQL;

@@clientName(Microsoft.DBforMySQL,
  "MySQLManagementFlexibleServerClient",
  "javascript"
);
@@clientName(Microsoft.DBforMySQL, "MySQLManagementClient", "python");

@@clientName(ServerVersion.`5.7`, "Five7", "javascript,go");
@@clientName(ServerVersion.`8.0.21`, "Eight021", "javascript,go");
@@clientName(ServerVersion.`5.7`, "FIVE7", "python");
@@clientName(ServerVersion.`8.0.21`, "EIGHT0_21", "python");

// Java SDK compatibility fixes for TypeSpec migration
@@clientName(Microsoft.DBforMySQL.MySQLServerIdentity, "Identity", "java");
@@clientName(Microsoft.DBforMySQL.MySQLServerSku, "Sku", "java");
@@clientName(Microsoft.DBforMySQL.ServerSkuTier, "SkuTier", "java");
@@clientName(DataEncryption.primaryKeyURI, "primaryKeyUri", "java");
@@clientName(DataEncryption.geoBackupKeyURI, "geoBackupKeyUri", "java");
