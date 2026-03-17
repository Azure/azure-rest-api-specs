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

// Fix enum member naming for backward compatibility (IPFIX → Ipfix)
@@clientName(Microsoft.NetworkFunction.EmissionType.IPFIX, "Ipfix", "csharp");
@@clientName(Microsoft.NetworkFunction.IngestionType.IPFIX, "Ipfix", "csharp");

// Fix ETag type for backward compatibility (string → Azure.ETag?)
@@alternateType(Microsoft.NetworkFunction.AzureTrafficCollector.etag,
  Azure.Core.eTag,
  "csharp"
);
@@alternateType(Microsoft.NetworkFunction.CollectorPolicy.etag,
  Azure.Core.eTag,
  "csharp"
);

// Fix ResourceReference.id type for backward compatibility (string → ResourceIdentifier)
@@alternateType(Microsoft.NetworkFunction.ResourceReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
