import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.PortalServices;

// java
@@clientName(Microsoft.PortalServices,
  "PortalServicesManagementClient",
  "java");