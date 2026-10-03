import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Advisor;

/** The name of a service group. */
@minLength(1)
@maxLength(90)
@pattern("^[a-zA-Z0-9\\-_().]{1,90}$")
scalar ServiceGroupName extends string;

/**
 * Advisor Recommendation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model ResourceRecommendationBase
  is Azure.ResourceManager.ExtensionResource<RecommendationProperties> {
  ...ResourceNameParameter<
    Resource = ResourceRecommendationBase,
    KeyName = "recommendationId",
    SegmentName = "recommendations",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/improper-subscription-list-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ResourceRecommendationBases {
  /**
   * Obtains details of a cached recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<
    ResourceRecommendationBase,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Error = ArmDefaultErrorResponse
  >;

  /**
   * Update the tracked properties of a Recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_05_01_preview)
  @removed(Versions.v2026_02_01_preview)
  @patch(#{ implicitOptionality: false })
  patch is ArmCustomPatchSync<
    ResourceRecommendationBase,
    PatchModel = TrackedRecommendationPropertiesPayload,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Error = ArmDefaultErrorResponse
  >;

  /**
   * Update the state of a Recommendation
   */
  @added(Versions.v2026_02_01_preview)
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchSync<
    Extension.Subscription,
    ResourceRecommendationBase,
    RecommendationPatchPayload
  >;

  /**
   * Obtains cached recommendations for a subscription. The recommendations are generated or computed by invoking generateRecommendations.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list is ArmResourceListByParent<
    ResourceRecommendationBase,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The filter to apply to the recommendations.<br>Filter can be applied to properties ['ResourceId', 'ResourceGroup', 'RecommendationTypeGuid', '[Category](#category)', 'SubCategory', 'RetirementDate', '[RecommendationStatus](#recommendationStatus)'] with operators ['eq', 'and', 'or', 'lt', 'gt', 'le', 'ge']<br>.
       * <br>The filter can also be applied to property ['trackingIds'], which uses the collection syntax `trackingIds/any(t: t eq '<trackingId>')`.<br>
       * <br>**Note:** `Control` is a legacy filter property and will be deprecated in the future. Please use `SubCategory` for filtering recommendation subcategory.<br>
       * <br>**Note:** `RecommendationStatus` filter is available from API Version 2026-02-01-preview and onwards.<br>
       * <br>**Note:** Each `trackingIds/any(...)` predicate matches a single tracking ID; supplying multiple values inside one predicate is not supported. To match several tracking IDs, combine predicates with `or`. `trackingIds` can also be combined with the other supported filter properties using `and`.<br>
       * <br>**Note:** A tracking ID is an Azure Service Health tracking ID, for example 'VN1S-1V8'. It is not a GUID and is not the same value as `RecommendationTypeGuid`. A single tracking ID can map to more than one recommendation type, so a result set filtered by `trackingIds` is not guaranteed to contain a single `RecommendationTypeGuid`. `trackingIds` is a filter-only property and is not returned on the recommendation resource; use the recommendation metadata API to resolve a tracking ID to the recommendation types that carry it.<br>
       * <br>Valid options for SubCategory:<br>['BusinessContinuity', 'DisasterRecovery', 'HighAvailability', 'MonitoringAndAlerting', 'Other', 'Personalized', 'PrioritizedRecommendations', 'Scalability', 'ServiceUpgradeAndRetirement', 'Validation']<br>
       * <br>Example:<br>- $filter=Category eq 'Cost' and ResourceGroup eq 'MyResourceGroup'<br>-$filter=SubCategory eq 'ServiceUpgradeAndRetirement' and RetirementDate le '2024-01-01' and RetirementDate ge '2028-01-01'. Filter can be applied on trackingIds as well.<br>- $filter=trackingIds/any(t: t eq 'VN1S-1V8')<br>- $filter=ResourceId eq '/subscriptions/{subscriptionId}/resourceGroups/MyResourceGroup/providers/Microsoft.Storage/storageAccounts/mystorage' and trackingIds/any(t: t eq 'VN1S-1V8')<br>- $filter=trackingIds/any(t: t eq 'VN1S-1V8') or trackingIds/any(t: t eq '6TH2-BV8')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of recommendations per page if a paged version of this API is being used.
       */
      @query("$top")
      $top?: int32;

      /**
       * The page-continuation token to use with a paged version of this API.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Error = ArmDefaultErrorResponse
  >;

  /**
   * Obtains cached recommendations for a subscription. The recommendations are generated or computed by invoking generateRecommendations.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByTenant is ArmResourceListByParent<
    ResourceRecommendationBase,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The filter to apply to the recommendations.<br>Filter can be applied to properties ['ResourceId', 'ResourceGroup', 'RecommendationTypeGuid', '[Category](#category)'] with operators ['eq', 'and', 'or'].<br>Example:<br>- $filter=Category eq 'Cost' and ResourceGroup eq 'MyResourceGroup'
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of recommendations per page if a paged version of this API is being used.
       */
      @query("$top")
      $top?: int32;

      /**
       * The page-continuation token to use with a paged version of this API.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Error = ArmDefaultErrorResponse
  >;
}

/** Operations for recommendations viewed in a service group scope. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface contains explicit service-group routes rather than standard ARM resource operations."
interface ServiceGroupRecommendationOperations {
  /** Lists recommendations for a service group. */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "The explicit operation returns a paged resource response or the standard ARM error response."
  @added(Versions.v2026_08_01_preview)
  @route("/providers/Microsoft.Management/serviceGroups/{serviceGroupName}/providers/Microsoft.Advisor/recommendations")
  @list
  @get
  listByServiceGroup(
    ...ApiVersionParameter,

    /** The name of the service group. */
    @path
    serviceGroupName: ServiceGroupName,

    /** Controls whether all recommendations or only contextually prioritized recommendations are returned. */
    @query
    mode?: RecommendationMode = RecommendationMode.All,

    /** The filter to apply to the recommendations. */
    @query("$filter")
    $filter?: string,

    /** The number of recommendations per page. */
    @query("$top")
    $top?: int32,

    /** The page-continuation token. */
    @query("$skipToken")
    $skipToken?: string,
  ):
    | ArmResponse<ResourceListResult<ResourceRecommendationBase>>
    | ArmDefaultErrorResponse;

  /** Gets a recommendation viewed in a service group scope. */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "The explicit operation returns a resource response or the standard ARM error response."
  @added(Versions.v2026_08_01_preview)
  @route("/providers/Microsoft.Management/serviceGroups/{serviceGroupName}/providers/Microsoft.Advisor/recommendations/{recommendationId}")
  @get
  getByServiceGroup(
    ...ApiVersionParameter,

    /** The name of the service group. */
    @path
    serviceGroupName: ServiceGroupName,

    /** The service-group-scoped recommendation identifier. */
    @path
    recommendationId: string,
  ): ArmResponse<ResourceRecommendationBase> | ArmDefaultErrorResponse;

  /** Updates the state of a recommendation viewed in a service group scope. */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "The explicit operation returns a resource response or the standard ARM error response."
  @added(Versions.v2026_08_01_preview)
  @route("/providers/Microsoft.Management/serviceGroups/{serviceGroupName}/providers/Microsoft.Advisor/recommendations/{recommendationId}")
  @patch
  patchByServiceGroup(
    ...ApiVersionParameter,

    /** The name of the service group. */
    @path
    serviceGroupName: ServiceGroupName,

    /** The service-group-scoped recommendation identifier. */
    @path
    recommendationId: string,

    /** The state properties to update. */
    @bodyRoot
    properties: RecommendationPatchPayload,
  ): ArmResponse<ResourceRecommendationBase> | ArmDefaultErrorResponse;
}

@@doc(ResourceRecommendationBase.name, "The recommendation ID.");
@@doc(
  ResourceRecommendationBase.properties,
  "The properties of the recommendation."
);
@@doc(
  ResourceRecommendationBases.patch::parameters.properties,
  "The properties to update on the recommendation."
);
