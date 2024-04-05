using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

using Azure.ResourceManager.Foundations;

namespace Oracle.Database;

// https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-operations#asynchronous-list-action
@armResourceOperations
interface InternalList {
  @doc("Generic Sync List operation")
  @autoRoute
  @segmentOf(TResource)
  @armResourceAction(TResource)
  @armResourceList(TResource)
  @action("ResourceReadBegin")
  @post
  op ResourceReadBeginListSync<TResource extends ArmResource, TRequest, TResponse, TBaseParameters = BaseParameters<TResource>>(
  ...ResourceParentParameters<TResource, TBaseParameters>,
  ...Azure.Core.StandardListQueryParameters,
    @doc("Body of read begin list")
    @body
    body: {value: TRequest[]},
    ): ArmResponse<TResponse> | ErrorResponse;
}

@armResourceOperations
interface ListActions {
  @doc("Generic Async Get operation")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @autoRoute
  @armResourceAction(TResource)
  @post
  op ArmResourceGetActionAsync<TResource extends ArmResource, TResponse, TBaseParameters = BaseParameters<TResource>>(
    ...ResourceInstanceParameters<TResource, TBaseParameters>,
  ): ArmResponse<TResponse> | ArmAcceptedLroResponse | ErrorResponse;
}