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
 * Managed compute capacity information for Cognitive Services managed compute deployments.
 * Provides available accelerator capacity per type and region at the subscription level.
 */
@added(Versions.v2026_03_15_preview)
@subscriptionResource
model ManagedComputeCapacity
  is Azure.ResourceManager.ProxyResource<ManagedComputeCapacityProperties> {
  ...ResourceNameParameter<
    Resource = ManagedComputeCapacity,
    KeyName = "managedComputeCapacityName",
    SegmentName = "managedComputeCapacities",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "'ManagedComputeCapacities' is a read-only resource type that does not support delete operations"
@added(Versions.v2026_03_15_preview)
@armResourceOperations(#{ omitTags: true })
interface ManagedComputeCapacities {
  /**
   * Gets the managed compute capacities for a subscription. Returns available capacity
   * per accelerator type, including deployment size information.
   */
  @tag("ManagedComputeCapacities")
  list is ArmResourceListByParent<
    ManagedComputeCapacity,
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
    Response = ManagedComputeCapacityListResult
  >;
}

@@doc(ManagedComputeCapacity.name,
  "The name of the managed compute capacity resource."
);
@@doc(ManagedComputeCapacity.properties,
  "Properties of the managed compute capacity resource."
);
