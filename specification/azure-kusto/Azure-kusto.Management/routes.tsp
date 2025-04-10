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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Clusters_ListSkus")
  @autoRoute
  @get
  @action("skus")
  listSkus is ArmProviderActionSync<
    Response = SkuDescriptionList,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Checks that the cluster name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Clusters_CheckNameAvailability")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Skus_List")
  @autoRoute
  @get
  @action("skus")
  list is ArmProviderActionSync<
    Response = SkuDescriptionList,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationsResultsOperationGroup {
  /**
   * Returns operation results.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OperationsResults_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Kusto/locations/{location}/operationResults/{operationId}")
  @get
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
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationsResultsLocationOperationGroup {
  /**
   * Returns operation results.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OperationsResultsLocation_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Kusto/locations/{location}/operationResults/{operationId}")
  @get
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
  ): OkResponse | ArmAcceptedResponse | ErrorResponse;
}
