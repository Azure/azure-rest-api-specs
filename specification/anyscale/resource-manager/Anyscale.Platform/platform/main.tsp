import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./agreements.tsp";
import "./cloud.tsp";
import "./cloudResource.tsp";
import "./computeConfig.tsp";
import "./containerImage.tsp";
import "./job.tsp";
import "./project.tsp";
import "./service.tsp";
import "./versions.tsp";
import "./workspace.tsp";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

/** Anyscale.Platform Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Anyscale.Platform management service" })
@versioned(Versions)
namespace Anyscale.Platform;

@@visibility(Azure.Core.Page.nextLink, Lifecycle.Read);

/** Operations interface */
interface Operations extends Azure.ResourceManager.Operations {}

/** Long-running operation status operations. */
@armResourceOperations
interface OperationStatuses {
  /** Returns the current status of an asynchronous operation. */
  @autoRoute
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @path
    @segment("providers")
    @doc("The resource provider namespace.")
    provider: "Anyscale.Platform",

    ...LocationResourceParameter,
    ...OperationIdParameter,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}
@@segment(OperationStatuses.get::parameters.operationId, "operationStatuses");
