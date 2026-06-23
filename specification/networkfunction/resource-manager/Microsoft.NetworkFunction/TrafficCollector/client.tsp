import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.NetworkFunction;
using Azure.ResourceManager;
using Azure.Core;

@@clientName(
  Microsoft.NetworkFunction,
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

@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ResourceReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  AzureTrafficCollectorPropertiesFormat.collectorPolicies,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);

// Change resource model inheritance from ProxyResource to TrackedResource for C#
// These resources have location and tags properties, making them tracked resources in the existing SDK
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  AzureTrafficCollector,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  CollectorPolicy,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

// Change etag type from string to Azure.Core.eTag for C#
@@alternateType(AzureTrafficCollector.etag, Azure.Core.eTag, "csharp");
@@alternateType(CollectorPolicy.etag, Azure.Core.eTag, "csharp");

@@clientLocation(
  Microsoft.NetworkFunction.Operations.list,
  "NetworkFunctionOperations",
  "csharp"
);

// We add this model in this namespace in order to replace some models with this model via alternateType decorator
namespace Azure.ResourceManager.Models {
  /** Represents a reference to an existing resource by its id. */
  model SubResource {
    /** The resource id. */
    id?: Azure.Core.armResourceIdentifier;
  }
}

// #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
// #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
// #suppress "@azure-tools/typespec-client-generator-core/no-corresponding-method-param" "override"
// op azureTrafficCollectorsCreateOrUpdate(
//   ...Azure.ResourceManager.ApiVersionParameter,
//   ...SubscriptionIdParameter,
//   ...ResourceGroupParameter,
//   ...ProviderNamespace<SubscriptionActionScope>,

//   /**
//    * azureTrafficCollectorName.
//    */
//   #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
//   azureTrafficCollectorName: string,

//   /**
//    * Resource location.
//    */
//   #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
//   location: string,

//   /**
//    * Resource tags.
//    */
//   #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
//   #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
//   tags?: Record<string>,

//   /**
//    * A unique read-only string that changes whenever the resource is updated.
//    */
//   #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
//   @visibility(Lifecycle.Read)
//   etag?: string,

//   /**
//    * The virtualHub to which the Azure Traffic Collector belongs.
//    */
//   virtualHub?: ResourceReference,

//   /**
//    * The name of the Azure Traffic Collector.
//    */
//   @visibility(Lifecycle.Read)
//   name?: string,
// ):
//   | Microsoft.NetworkFunction.AzureTrafficCollector
//   | Azure.Core.Foundations.RetryAfterHeader
//   | Microsoft.NetworkFunction.CloudError;
// @@override(
//   AzureTrafficCollectors.createOrUpdate,
//   azureTrafficCollectorsCreateOrUpdate,
//   "javascript"
// );
namespace Microsoft.NetworkFunction {
  @@scope(AzureTrafficCollectors.createOrUpdate, "!javascript");

  @armResourceOperations
  interface AzureTrafficCollectorsScope {
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "client customization"
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
    createOrUpdate(
      ...Azure.ResourceManager.Foundations.DefaultBaseParameters<AzureTrafficCollector>,
      ...Azure.ResourceManager.ProviderNamespace<AzureTrafficCollector>,

      /**
       * azureTrafficCollectorName.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      azureTrafficCollectorName: string,

      /**
       * Resource location.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      location: string,

      /**
       * Resource tags.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      tags?: Record<string>,

      /**
       * A unique read-only string that changes whenever the resource is updated.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @visibility(Lifecycle.Read)
      etag?: string,

      /**
       * The virtualHub to which the Azure Traffic Collector belongs.
       */
      virtualHub?: ResourceReference,
    ):
      | ArmResourceUpdatedResponse<AzureTrafficCollector>
      | ArmResourceCreatedResponse<
          AzureTrafficCollector,
          ArmAsyncOperationHeader<FinalResult = AzureTrafficCollector> &
            Azure.Core.Foundations.RetryAfterHeader
        >
      | CloudError;
  }

  @@scope(AzureTrafficCollectorsScope.createOrUpdate, "javascript");
  @@clientLocation(
    AzureTrafficCollectorsScope.createOrUpdate,
    "AzureTrafficCollectors",
    "javascript"
  );
}
