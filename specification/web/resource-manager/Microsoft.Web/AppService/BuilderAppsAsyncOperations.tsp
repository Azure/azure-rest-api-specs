import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "./BuilderApp.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/** Parameters for a location-scoped operation result, independent of the app resource. */
@added(Versions.v2026_11_15)
model BuilderAppOperationResultParameters {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;

  /** Provider namespace. */
  @path @segment("providers") provider: "Microsoft.Web";

  ...LocationResourceParameter;
  ...Foundations.OperationIdParameter;
}

@@segment(
  BuilderAppOperationResultParameters.operationId,
  "builderAppsOperationResults"
);

/** Location-scoped polling that remains available after the app resource is deleted. */
@added(Versions.v2026_11_15)
@armResourceOperations
interface BuilderAppsAsyncOperations {
  /** Get operation state. Operation failure is expressed in status and error rather than a successful final result. */
  getOperationStatus is GetResourceOperationStatus<
    CommonTypes.OperationStatusResult,
    SubscriptionLocationActionScope,
    Error = DefaultErrorResponse
  >;

  /** Get the location-scoped operation result resource. Pending operations return 202; completion returns 200, including after deletion. Read operation failure details from the status monitor. */
  @get
  @autoRoute
  getOperationResult is Foundations.ArmReadOperation<
    BuilderAppOperationResultParameters,
    | ArmResponse<CommonTypes.Resource>
    | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<
        ArmOperationStatus,
        CommonTypes.Resource
      > &
        Azure.Core.Foundations.RetryAfterHeader>,
    DefaultErrorResponse
  >;
}

@@segment(
  BuilderAppsAsyncOperations.getOperationStatus::parameters.operationId,
  "builderAppsOperationStatuses"
);
