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

/** Status of a shared builder app asynchronous operation. */
@added(Versions.v2026_11_15)
@Azure.Core.lroStatus
union BuilderAppOperationState {
  /** Operation is pending or running. */
  InProgress: "InProgress",

  /** Operation completed successfully. */
  Succeeded: "Succeeded",

  /** Operation failed. */
  Failed: "Failed",

  /** Operation was canceled. */
  Canceled: "Canceled",

  string,
}

/** Shared status monitor for deployment, identity, and deletion operations. */
@added(Versions.v2026_11_15)
model BuilderAppOperationStatus
  is ArmOperationStatus<StatusValues = BuilderAppOperationState>;

/** ARM error returned when a shared operation has failed or been canceled. */
@added(Versions.v2026_11_15)
@error
model BuilderAppOperationConflictResult {
  ...ConflictResponse;
  ...ErrorResponse;
}

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
    BuilderAppOperationStatus,
    SubscriptionLocationActionScope,
    Error = DefaultErrorResponse
  >;

  /** Get the completed builder app, or 204 after deletion. Pending operations return 202; failed or canceled operations return 409 with an ARM error. */
  @get
  @autoRoute
  getOperationResult is Foundations.ArmReadOperation<
    BuilderAppOperationResultParameters,
    ArmResponse<BuilderApp> | ArmAcceptedLroResponse | NoContentResponse,
    BuilderAppOperationConflictResult | DefaultErrorResponse
  >;
}

@@segment(
  BuilderAppsAsyncOperations.getOperationStatus::parameters.operationId,
  "builderAppsOperationStatuses"
);
