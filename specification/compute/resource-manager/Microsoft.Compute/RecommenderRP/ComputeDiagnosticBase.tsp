import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using Versioning;

namespace Microsoft.Compute;
/**
 * Contains metadata of a diagnostic type
 */
@singleton("spot")
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model ComputeDiagnosticBase
  is Azure.ResourceManager.ProxyResource<DiagnosticProperties> {
  ...ResourceNameParameter<
    Resource = ComputeDiagnosticBase,
    KeyName = "placementScore",
    SegmentName = "placementScores",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ComputeDiagnosticBases {
  /**
   * Gets Spot Placement Scores metadata.
   */
  get is ArmResourceRead<
    ComputeDiagnosticBase,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Generates placement scores for Spot VM skus.
   */
  @action("generate")
  post is ArmResourceActionSync<
    ComputeDiagnosticBase,
    SpotPlacementScoresInput,
    ArmResponse<SpotPlacementScoresResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(ComputeDiagnosticBase.name, "");
@@doc(ComputeDiagnosticBase.properties,
  "Contains additional properties of a diagnostic"
);
@@doc(ComputeDiagnosticBases.post::parameters.body,
  "SpotPlacementScores object supplied in the body of the Post spot placement scores operation."
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@added(Versions.v2025_06_05_preview)
interface CapacityBlocksOperationGroup {
  /**
   * Get available capacity blocks.
   */
  @get
  @action("capacityBlocks")
  get is ArmProviderActionSync<
    Response = CapacityBlocks,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * An OData filter expression that describes a subset of capacity blocks to return. Mandatory parameters are sku, capacity, durationhours, start-date-range and end-date-range. Optional parameters are zone and location. The supported operator is eq. Example: $filter = sku eq Standard_D16s_v4 and capacity eq 4 and start-date-range eq 2025-06-25T00:00:00-07:00 and end-date-range eq 2025-06-27T00:00:00-07:00 and durationhours eq 24 and zone eq 1 and location eq westus
       */
      @query("$filter")
      $filter: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@added(Versions.v2025_06_05_preview)
interface RegionalCapacityBlocksOperationGroup {
  /**
   * Get available capacity blocks by location.
   */
  @get
  @action("capacityBlocks")
  get is ArmProviderActionSync<
    Response = CapacityBlocks,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationParameter;

      /**
       * An OData filter expression that describes a subset of capacity blocks to return. Mandatory parameters are sku, capacity, durationhours, start-date-range and end-date-range. Optional parameters are zone. The supported operator is eq. Example: $filter = sku eq Standard_D16s_v4 and capacity eq 4 and start-date-range eq 2025-06-25T00:00:00-07:00 and end-date-range eq 2025-06-27T00:00:00-07:00 and durationhours eq 24 and zone eq 1
       */
      @query("$filter")
      $filter: string;
    }
  >;
}