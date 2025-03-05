import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceFabric;

@@Azure.ClientGenerator.Core.clientName(ManagedMaintenanceWindowStatusContent,
  "ManagedMaintenanceWindowStatus"
);
@@Azure.ClientGenerator.Core.clientName(ManagedAzResiliencyStatusContent,
  "ManagedAzResiliencyStatus"
);
