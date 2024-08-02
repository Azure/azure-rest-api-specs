import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.DocumentDB, "MongoClusterMgmtClient", "python");
@@clientName(Microsoft.DocumentDB,
    "MongoClusterManagementClient",
    "javascript"
);
