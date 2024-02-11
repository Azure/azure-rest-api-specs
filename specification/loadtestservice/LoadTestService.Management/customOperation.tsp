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

@armResourceOperations
interface CustomOperations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "OperationId is already published"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-action-verb" "Operation is GET but endpoint is similar to action on resource"
  @armResourceList(TResource)
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
  OutboundNetworkDependenciesEndpoint<TResource extends TypeSpec.Reflection.Model>(
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
  #suppress "@azure-tools/typespec-azure-resource-manager/retry-after" "Retry-After header is not in already published"
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
  ArmResourceCreateOrUpdateAsyncCustom<
    TResource extends ArmResource,
    TBaseParameters = BaseParameters<TResource>
  >(
    ...ResourceInstanceParameters<TResource, TBaseParameters>,

    #suppress "@azure-tools/typespec-azure-core/casing-style" "LoadTestResource is already published"
    @doc("Resource create parameters.")
    @body
    LoadTestResource: TResource,
  ): ArmResourceUpdatedResponse<TResource> | ArmResourceCreatedResponseCustom | ErrorResponse;

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
  ArmResourceActionSyncCustom<
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

  // adding a custom operation since we want to override body parameter name to LoadTestResourcePatchRequestBody
  /**
   * A long-running resource update using a custom PATCH payload (Asynchronous)
   * @template Resource the resource being patched
   * @template PatchModel The input model for the PATCH request
   * @template BaseParameters Optional. Allows overriding the operation parameters
   * @template LroHeaders Optional.  Allows overriding the lro headers returned in the Accepted response
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/retry-after" "Retry-After header is not in already published"
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
  ArmCustomPatchAsyncCustom<
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

  /**
   * @dev Delete a resource asynchronously
   * @template Resource The resource being deleted
   * @template Response The response type for the operation
   * @template BaseParameters Optional. Allows overriding the parameters for the operation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/retry-after" "Retry-After header is not in already published"
  @autoRoute
  @doc("Delete a {name}", Resource)
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @armResourceDelete(Resource)
  @delete
  ArmResourceDeleteAsyncCustom<
    Resource extends ArmResource,
    Response = ArmDeletedResponse | ArmAcceptedLroDeleteResponseCustom | ArmDeletedNoContentResponse,
    BaseParameters = DefaultBaseParameters<Resource>
  >(
    ...ResourceInstanceParameters<Resource, BaseParameters>,
  ): Response | ErrorResponse;
}

// Removed header retry-after from the response
@doc("Accepted -- LoadTest resource patch request accepted.")
model ArmAcceptedResponseCustom {
  ...AcceptedResponse;
  ...ArmAsyncOperationHeader;
}

// Removed header retry-after from the response
@doc("Created -- LoadTest resource created.")
model ArmResourceCreatedResponseCustom {
  ...CreatedResponse;
  ...Body<LoadTestResource>;
  ...ArmAsyncOperationHeader;
}

@doc("Resource deletion accepted.")
model ArmAcceptedLroDeleteResponseCustom{
  ...AcceptedResponse;
  ...ArmLroLocationHeader;
}

@doc("The response of a {name} list operation.", LoadTestResource)
model LoadTestResourcePageList{
  @doc("The {name} items on this page", LoadTestResource)
  @items
  value?: LoadTestResource[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<LoadTestResource>;
}

@doc("The response of a {name} list operation.", QuotaResource)
model QuotaResourceList{
  @doc("The {name} items on this page", QuotaResource)
  @items
  value?: QuotaResource[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<QuotaResource>;
}