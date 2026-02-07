import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Peering, "PeeringManagementClient", "python,javascript");
@@clientName(Microsoft.Peering.CheckServiceProviderAvailabilityResponse,
  "Enum0",
  "go, javascript"
);


@@clientName(Microsoft.Peering.PeeringPropertiesDirect,
  "DirectPeeringProperties ",
  "csharp"
);

@@clientName(Microsoft.Peering.PeeringPropertiesExchange,
  "ExchangePeeringProperties ",
  "csharp"
);

@@clientName(Microsoft.Peering.DirectConnection,
  "PeeringDirectConnection ",
  "csharp"
);

@@clientName(Microsoft.Peering.ExchangeConnection,
  "PeeringExchangeConnection ",
  "csharp"
);

@@clientName(Microsoft.Peering.PeeringLocationPropertiesDirect,
  "DirectPeeringLocationProperties",
  "csharp"
);

@@clientName(Microsoft.Peering.LogAnalyticsWorkspaceProperties,
  "PeeringLogAnalyticsWorkspaceProperties",
  "csharp"
);

@@clientName(Microsoft.Peering.ProvisioningState,
  "PeeringProvisioningState",
  "csharp"
);

@@clientName(Microsoft.Peering.PeeringLocationProperties.peeringLocation,
  "MyLocation",
  "csharp"
);

//PeeringLocationProperties

//PeeringLogAnalyticsWorkspaceProperties'

//PeeringPropertiesExchange

//ProvisioningState
