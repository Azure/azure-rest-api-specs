import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.NetworkFunction,
  "AzureTrafficCollectorClient",
  "javascript"
);

@@clientName(Microsoft.NetworkFunction, "TrafficCollectorMgmtClient", "python");

// C# renames to preserve backward compatibility with the existing SDK
@@clientName(Microsoft.NetworkFunction.ProvisioningState,
  "CollectorProvisioningState",
  "csharp"
);
@@clientName(Microsoft.NetworkFunction.DestinationType,
  "EmissionDestinationType",
  "csharp"
);
@@clientName(Microsoft.NetworkFunction.SourceType,
  "IngestionSourceType",
  "csharp"
);

// Fix ARM common type id to use ResourceIdentifier instead of string
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
