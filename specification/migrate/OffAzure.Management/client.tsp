import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.OffAzure;

// Mitigate Java breaking changes: model renames (case changes from Swagger → TypeSpec)
@@clientName(FCIInstanceState, "FciInstanceState", "java");
@@clientName(FileMetaData, "FileMetadata", "java");
@@clientName(MicrosoftAzureFDSWebRoleHealthErrorDetailsSource,
  "MicrosoftAzureFdsWebRoleHealthErrorDetailsSource",
  "java"
);
@@clientName(SQLDiscoveryScopeStatus, "SqlDiscoveryScopeStatus", "java");
@@clientName(SQLInventoryImportBody, "SqlInventoryImportBody", "java");
