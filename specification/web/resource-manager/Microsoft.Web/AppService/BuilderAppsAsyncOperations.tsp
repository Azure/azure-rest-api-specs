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
@added(Versions.v2026_09_01_preview)
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
@added(Versions.v2026_09_01_preview)
model BuilderAppOperationStatus
  is ArmOperationStatus<StatusValues = BuilderAppOperationState>;

/** Location-scoped polling that remains available after the app resource is deleted. */
@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface BuilderAppsAsyncOperations {
  /** Get operation state. Operation failure is expressed in status and error rather than a successful final result. */
  #suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "This provider-location status monitor is not a resource-instance read and must remain independent of the app lifecycle."
  @get
  @autoRoute
  getOperationStatus(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** Provider namespace. */
    @path @segment("providers") provider: "Microsoft.Web",

    ...LocationResourceParameter,
    ...Foundations.OperationIdParameter,
  ): ArmResponse<BuilderAppOperationStatus> | DefaultErrorResponse;

  /** Get the completed builder app, or 204 after deletion. Pending operations return 202; failed or canceled operations return 409 with an ARM error. */
  #suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "This shared provider-location result endpoint is not a resource-instance read and supports completed deletion."
  @get
  @autoRoute
  getOperationResult(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** Provider namespace. */
    @path @segment("providers") provider: "Microsoft.Web",

    ...LocationResourceParameter,
    ...Foundations.OperationIdParameter,
  ):
    | ArmResponse<BuilderApp>
    | ArmAcceptedLroResponse
    | NoContentResponse
    | (ConflictResponse & ErrorResponse)
    | DefaultErrorResponse;
}

@@segment(
  BuilderAppsAsyncOperations.getOperationStatus::parameters.operationId,
  "builderAppsOperationStatuses"
);
@@segment(
  BuilderAppsAsyncOperations.getOperationResult::parameters.operationId,
  "builderAppsOperationResults"
);
