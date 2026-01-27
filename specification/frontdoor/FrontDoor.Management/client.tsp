import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@clientName(Microsoft.Network,
  "FrontDoorManagementClient",
  "python, javascript"
);
@@clientName(MinimumTLSVersion.`1.0`, "ONE0", "python, javascript");
@@clientName(MinimumTLSVersion.`1.2`, "ONE2", "python, javascript");
