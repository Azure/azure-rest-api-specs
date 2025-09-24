import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Edge,
  "DisconnectedOperationsManagementClient",
  "javascript"
);
@@clientName(Microsoft.Edge.Versions.v2025_06_01,
  "V20250601Preview",
  "javascript"
);
