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
@@alternateType(AzureTrafficCollector,
  NetworkFunctionAzureTrafficCollector,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkFunctionAzureTrafficCollector.properties);
@@alternateType(CollectorPolicy, NetworkFunctionCollectorPolicy, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkFunctionCollectorPolicy.properties);

@@clientLocation(Operations.list, "NetworkFunctionOperations", "csharp");

// added to solve the problem that the c# resource class can inherit the `tracked resource data` class
namespace Microsoft.NetworkFunction {
  /**
   * Azure Traffic Collector resource.
   */
  model NetworkFunctionAzureTrafficCollector
    is Azure.ResourceManager.TrackedResource<AzureTrafficCollectorPropertiesFormat> {
    ...Azure.ResourceManager.ResourceNameParameter<
      Resource = AzureTrafficCollector,
      KeyName = "azureTrafficCollectorName",
      SegmentName = "azureTrafficCollectors",
      NamePattern = ""
    >;
    ...OmitProperties<
      AzureTrafficCollector,
      "id" | "name" | "type" | "properties" | "location" | "tags" | "etag"
    >;

    /**
     * A unique read-only string that changes whenever the resource is updated.
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @visibility(Lifecycle.Read)
    etag?: Azure.Core.eTag;
  }

  /**
   * Collector policy resource.
   */
  @TypeSpec.Rest.parentResource(AzureTrafficCollector)
  model NetworkFunctionCollectorPolicy
    is Azure.ResourceManager.TrackedResource<CollectorPolicyPropertiesFormat> {
    ...Azure.ResourceManager.ResourceNameParameter<
      Resource = CollectorPolicy,
      KeyName = "collectorPolicyName",
      SegmentName = "collectorPolicies",
      NamePattern = ""
    >;
    ...OmitProperties<
      CollectorPolicy,
      "id" | "name" | "type" | "properties" | "location" | "tags" | "etag"
    >;

    /**
     * A unique read-only string that changes whenever the resource is updated.
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @visibility(Lifecycle.Read)
    etag?: Azure.Core.eTag;
  }
}

// We add this model in this namespace in order to replace some models with this model via alternateType decorator
namespace Azure.ResourceManager.Models {
  /** Represents a reference to an existing resource by its id. */
  model SubResource {
    /** The resource id. */
    id?: Azure.Core.armResourceIdentifier;
  }
}
