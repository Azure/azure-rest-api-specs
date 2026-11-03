using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.PlatformValidation;

@doc("Provides the OData '$filter' query parameter for list operations.")
model OdataFilterQueryParameter {
  @query("$filter")
  @doc("The OData filter expression to apply to the list operation.")
  filter?: string;
}

@armResourceOperations
@tag("Operation Status Interfaces")
interface OperationStatus {
  @doc("Returns the current status of an async operation.")
  @autoRoute
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @path
    @segment("providers")
    @doc("The provider namespace (this parameter will not show up in operations).")
    provider: "Microsoft.PlatformValidation",

    ...LocationResourceParameter,
    ...Azure.ResourceManager.Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}

@@segment(OperationStatus.get::parameters.operationId, "operationStatuses");
