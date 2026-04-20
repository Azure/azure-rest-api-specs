import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.NetworkFunction;

@@clientName(Microsoft.NetworkFunction,
  "AzureTrafficCollectorClient",
  "javascript"
);

@@clientName(Microsoft.NetworkFunction, "TrafficCollectorMgmtClient", "python");

// C# renames to preserve backward compatibility with the existing SDK
@@clientName(ProvisioningState, "CollectorProvisioningState", "csharp");
@@clientName(DestinationType, "EmissionDestinationType", "csharp");
@@clientName(SourceType, "IngestionSourceType", "csharp");
@@clientName(EmissionType.IPFIX, "Ipfix", "csharp");
@@clientName(IngestionType.IPFIX, "Ipfix", "csharp");

@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ResourceReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AzureTrafficCollectorPropertiesFormat.collectorPolicies,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);

// Change resource model inheritance from ProxyResource to TrackedResource for C#
// These resources have location and tags properties, making them tracked resources in the existing SDK
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(AzureTrafficCollector,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(CollectorPolicy,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

// Change etag type from string to Azure.Core.eTag for C#
@@alternateType(AzureTrafficCollector.etag, Azure.Core.eTag, "csharp");
@@alternateType(CollectorPolicy.etag, Azure.Core.eTag, "csharp");

@@clientLocation(Operations.list, "NetworkFunctionOperations", "csharp");

// We add this model in this namespace in order to replace some models with this model via alternateType decorator
namespace Azure.ResourceManager.Models {
  /** Represents a reference to an existing resource by its id. */
  model SubResource {
    /** The resource id. */
    id?: Azure.Core.armResourceIdentifier;
  }
}
