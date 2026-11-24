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
}

@@segment(
  BuilderAppsAsyncOperations.getOperationStatus::parameters.operationId,
  "builderAppsOperationStatuses"
);
