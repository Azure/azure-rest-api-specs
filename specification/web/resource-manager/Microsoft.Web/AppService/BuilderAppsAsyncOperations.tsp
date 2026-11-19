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

  /** Get a location-scoped operation result. Pending operations return bodyless 202. Successful identity saves return 200 with the BuilderApp; successful deployments, start and stop actions, and deletions return 204. Failed operations return their stored error. */
  @get
  @autoRoute
  getOperationResult is Foundations.ArmReadOperation<
    BuilderAppOperationResultParameters,
    | ArmResponse<BuilderApp>
    | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<
        Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
        BuilderApp,
        string
      > &
        Azure.Core.Foundations.RetryAfterHeader>
    | ArmNoContentResponse<"The deployment, runtime action, or deletion completed successfully.">,
    DefaultErrorResponse
  >;
}

@@segment(
  BuilderAppsAsyncOperations.getOperationStatus::parameters.operationId,
  "builderAppsOperationStatuses"
);
