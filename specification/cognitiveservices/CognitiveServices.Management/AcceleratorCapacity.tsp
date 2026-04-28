import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * Accelerator capacity information for Cognitive Services managed compute deployments.
 * Provides available accelerator capacity per type and region at the subscription level.
 */
@added(Versions.v2026_03_15_preview)
@subscriptionResource
model AcceleratorCapacity
  is Azure.ResourceManager.ProxyResource<AcceleratorCapacityProperties> {
  ...ResourceNameParameter<
    Resource = AcceleratorCapacity,
    KeyName = "acceleratorCapacityName",
    SegmentName = "acceleratorCapacities",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "'AcceleratorCapacities' is a read-only resource type that does not support delete operations"
@added(Versions.v2026_03_15_preview)
@armResourceOperations(#{ omitTags: true })
interface AcceleratorCapacities {
  /**
   * Gets the accelerator capacities for a subscription. Returns available capacity
   * per accelerator type, including deployment size information.
   */
  @tag("AcceleratorCapacities")
  list is ArmResourceListByParent<
    AcceleratorCapacity,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The offer name to query capacity for (required).
       */
      @query("offer")
      offer: string;

      /**
       * Optional accelerator type filter to narrow results to a specific accelerator type.
       */
      @query("acceleratorType")
      acceleratorType?: string;

      /**
       * Optional deployment resource ID. When provided, returns capacity for the specific region
       * where the deployment is hosted rather than the best available region.
       */
      @query("deploymentId")
      deploymentId?: string;
    },
    Response = AcceleratorCapacityListResult
  >;
}

@@doc(AcceleratorCapacity.name,
  "The name of the accelerator capacity resource."
);
@@doc(AcceleratorCapacity.properties,
  "Properties of the accelerator capacity resource."
);
