import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;

/**
 * Static Sites async operation status and result resource operations.
 */
@armResourceOperations
@added(Versions.v2026_03_15)
interface StaticSitesAsyncOperations {
  /**
   * Gets the status of a static site async operation.
   */
  @autoRoute
  @summary("Gets the status of a static site async operation.")
  getOperationStatus(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The provider namespace (this parameter will not show up in operations).
     */
    @path
    @segment("providers")
    provider: "Microsoft.Web",

    ...LocationResourceParameter,
    ...Foundations.OperationIdParameter,
  ): ArmResponse<StaticSitesOperationStatus> | DefaultErrorResponse;

  /**
   * Gets the result of a static site async operation.
   */
  @autoRoute
  @summary("Gets the result of a static site async operation.")
  getOperationResult(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The provider namespace (this parameter will not show up in operations).
     */
    @path
    @segment("providers")
    provider: "Microsoft.Web",

    ...LocationResourceParameter,
    ...Foundations.OperationIdParameter,
  ):
    | ArmResponse<Azure.ResourceManager.CommonTypes.Resource>
    | ArmAcceptedLroResponse
    | DefaultErrorResponse;
}

@@segment(
  StaticSitesAsyncOperations.getOperationStatus::parameters.operationId,
  "staticSitesOperationStatuses"
);
@@segment(
  StaticSitesAsyncOperations.getOperationResult::parameters.operationId,
  "staticSitesOperationResults"
);
