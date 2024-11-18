import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

/**
 * Chaos Studio async operation status resource.
 */
@parentResource(ArmLocationResource<"Subscription">)
model OperationStatus is Azure.ResourceManager.ArmOperationStatus;

// @armResourceOperations
// interface OperationStatuses {
//   @doc("Get the status of an operation.")
//   get is ArmResourceRead<OperationStatus>;
// }

@armResourceOperations
interface OperationStatuses {
  @doc("Returns the current status of an async operation.")
  @autoRoute
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @path
    @segment("providers")
    @doc("The provider namespace (this parameter will not show up in operations).")
    provider: "Microsoft.Chaos",

    ...LocationParameter,
    ...Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatus> | ErrorResponse;
}

@@segment(OperationStatuses.get::parameters.operationId, "operationStatuses");
