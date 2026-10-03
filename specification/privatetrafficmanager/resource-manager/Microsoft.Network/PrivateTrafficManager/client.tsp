import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Network, "PrivateTrafficManagerMgmtClient", "python");
@@clientName(
  Microsoft.Network,
  "PrivateTrafficManagerManagementClient",
  "javascript"
);
