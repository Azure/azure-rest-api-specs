import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.BareMetalInfrastructure;
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.BareMetalInfrastructure,
  "BareMetalInfrastructureClient",
  "python"
);

@@clientName(Azure.ResourceManager.CommonTypes.OperationDisplay,
  "Display",
  "java"
);

@@clientName(NetworkInterface, "IpAddress", "java");
