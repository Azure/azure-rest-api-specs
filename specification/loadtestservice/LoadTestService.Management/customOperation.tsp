import "./models.tsp";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
using Autorest;
using Azure.ResourceManager.Foundations;

namespace Microsoft.LoadTestService;

#suppress "@azure-tools/typespec-azure-core/no-operation-id" "OperationId is already published"
@get
@doc("Lists the endpoints that agents may call as part of load testing.")
@operationId("LoadTests_ListOutboundNetworkDependenciesEndpoints")
@extension(
"x-ms-pageable",
{
    nextLinkName: "nextLink",
}
)
@autoRoute
@action("outboundNetworkDependenciesEndpoints")
op OutboundNetworkDependenciesEndpoint<TResource>(
...SubscriptionIdParameter,
...ResourceGroupParameter,
...ApiVersionParameter,

@path
@doc("Load Test name.")
@segment("providers/Microsoft.LoadTestService/loadTests")
@extension("x-ms-parameter-location", "method")
loadTestName: string,
): TResource | ErrorResponse;

// adding a custom operation since we want to override body parameter name to LoadTestResource
/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
@autoRoute
@doc("Create a {name}", TResource)
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "azure-async-operation",
  }
)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdateAsyncCustom<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  #suppress "@azure-tools/typespec-azure-core/casing-style" "LoadTestResource is already published"
  @doc("Resource create parameters.")
  @body
  LoadTestResource: TResource,
): ArmResourceUpdatedResponse<TResource> | ArmResourceCreatedResponse<TResource> | ErrorResponse;

// adding a custom operation since we want to override body parameter name to QuotaBucketRequest
/**
 * A synchronous resource action.
 * @template TResource The resource being acted upon
 * @template TRequest The request model for the action
 * @template TResponse The response model for the action
 * @template TBaseParameters Optional. Allows overriding the parameters for the operation
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "QuotaBucketRequest is already published"
@autoRoute
@armResourceAction(TResource)
@post
@returnsDoc("ARM operation completed successfully.")
op ArmResourceActionSyncCustom<
  TResource extends ArmResource,
  TRequest extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("The content of the action request")
  @body
  QuotaBucketRequest: TRequest,
): TResponse | ErrorResponse;


/**
 * A long-running resource update using a custom PATCH payload (Asynchronous)
 * @template Resource the resource being patched
 * @template PatchModel The input model for the PATCH request
 * @template BaseParameters Optional. Allows overriding the operation parameters
 * @template LroHeaders Optional.  Allows overriding the lro headers returned in the Accepted response
 */
@autoRoute
@doc("Update a {name}", Resource)
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "location",
  }
)
@armResourceUpdate(Resource)
@patch
op ArmCustomPatchAsyncCustom<
  Resource extends ArmResource,
  PatchModel extends TypeSpec.Reflection.Model = TagsUpdateModel<Resource>,
  BaseParameters = DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
    Resource,
    string
  >
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,

  #suppress "@azure-tools/typespec-azure-core/casing-style" "LoadTestResourcePatchRequestBody is already published"
  @doc("The resource properties to be updated.")
  @body
  LoadTestResourcePatchRequestBody: PatchModel,
): ArmResponse<Resource> | ArmAcceptedResponseCustom | ErrorResponse;

@doc("Accepted -- LoadTest resource patch request accepted")
model ArmAcceptedResponseCustom{
  ...AcceptedResponse,
  ...ArmAsyncOperationHeader
}

