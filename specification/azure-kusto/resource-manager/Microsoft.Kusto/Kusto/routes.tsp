// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ClustersOperationGroup {
  /**
   * Lists eligible SKUs for Kusto resource provider.
   */
  @autoRoute
  @list
  @get
  @action("skus")
  listSkus is ArmProviderActionSync<
    Response = SkuDescriptionList,
    Scope = SubscriptionActionScope
  >;
  /**
   * Checks that the cluster name is valid and is not already in use.
   */
  @tag("Clusters")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = ClusterCheckNameRequest,
    Response = CheckNameResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SkusOperationGroup {
  /**
   * Lists eligible region SKUs for Kusto resource provider by Azure region.
   */
  @autoRoute
  @list
  @get
  @action("skus")
  list is ArmProviderActionSync<
    Response = SkuDescriptionList,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface OperationsResultsOperationGroup {
  /**
   * Returns operation results.
   */
  @tag("OperationResults")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Kusto/locations/{location}/operationResults/{operationId}")
  @get
  @sharedRoute
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The ID of an ongoing async operation.
     */
    @minLength(1)
    @path
    operationId: string,
  ): ArmResponse<OperationResult> | ErrorResponse;

  /**
   * Returns operation results.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("OperationResults")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Kusto/locations/{location}/operationResults/{operationId}?operationResultResponseType=Location")
  @get
  @sharedRoute
  getLocation(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The ID of an ongoing async operation.
     */
    @minLength(1)
    @path
    operationId: string,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @query
    operationResultResponseType: "Location",
  ): OkResponse | ArmAcceptedResponse<
    Message = "Operation is still in progress.",
    ExtraHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;
}
