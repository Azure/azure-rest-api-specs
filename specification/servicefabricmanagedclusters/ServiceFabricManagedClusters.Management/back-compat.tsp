import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceFabric;

@@clientName(ManagedMaintenanceWindowStatusContent,
  "ManagedMaintenanceWindowStatus"
);
@@clientName(ManagedAzResiliencyStatusContent, "ManagedAzResiliencyStatus");

@@clientName(ManagedAzResiliencyStatus, "ManagedAzResiliencyStatuses", "java");
@@clientName(ManagedMaintenanceWindowStatus,
  "ManagedMaintenanceWindowStatuses",
  "java"
);

@@clientName(PublicIPAddressConfiguration,
  "IPConfigurationPublicIPAddressConfiguration",
  "go, java, javascript, python"
);
