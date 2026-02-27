import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Peering, "PeeringManagementClient", "python,javascript");
@@clientName(Microsoft.Peering.CheckServiceProviderAvailabilityResponse,
  "Enum0",
  "go, javascript"
);
