using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Autorest;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager;

// OPERATION TEMPLATES
// @autoRoute
// @doc("List {name} resources by subscription ID", TResource)
// @list(TResource)
// @segmentOf(TResource)
// @armResourceList(TResource)
// @get
// op ArmListBySubscription<TResource extends ArmResource>(
//   ...SubscriptionScope<TResource>
// ): ArmResponse<ResourceListResultUpdated<TResource>> ;

// @get
// @autoRoute
// @list(TResource)
// @segmentOf(TResource)
// @armRenameListByOperation(TResource, TParentName, TParentFriendlyName) // This must come before @armResourceList!
// @armResourceList(TResource)
// op ArmResourceListByParent<
//   TResource extends ArmResource,
//   TBaseParameters = BaseParameters<TResource>,
//   TParentName = "",
//   TParentFriendlyName = ""
// >(
//   ...ResourceParentParameters<TResource, TBaseParameters>
// ): ArmResponse<ResourceListResultUpdated<TResource>> ;

// @get
// @autoRoute
// @list(TResource)
// @segmentOf(TResource)
// @armRenameListByOperation(TResource) // This must come before @armResourceList!
// @armResourceList(TResource)
// op ArmResourceListAtScope<
//   TResource extends ArmResource,
//   TBaseParameters = BaseParameters<TResource>
// >(
//   ...ResourceParentParameters<TResource, TBaseParameters>
// ): ArmResponse<ResourceListResultUpdated<TResource>> ;

// @autoRoute
// @doc("Get a {name}", TResource)
// @get
// @armResourceRead(TResource)
// op ArmResourceRead<TResource extends ArmResource, TBaseParameters = BaseParameters<TResource>>(
//   ...ResourceInstanceParametersCustom<TResource, TBaseParameters>
// ): ArmResponse<TResource> ;

// @autoRoute
// @doc("Create a {name}", TResource)
// @extension("x-ms-long-running-operation", true)
// @extension(
//   "x-ms-long-running-operation-options",
//   {
//     "final-state-via": "location",
//   }
// )
// @armResourceCreateOrUpdate(TResource)
// @put
// op ArmResourceCreateOrUpdateAsync<
//   TResource extends ArmResource,
//   TBaseParameters = BaseParameters<TResource>
// >(
//   ...ResourceInstanceParametersCustom<TResource, TBaseParameters>,

//   @doc("Resource create parameters.")
//   @body
//   body: TResource
// ): ArmAcceptedResponse<"Accepted."> ;

// @autoRoute
// @doc("Create a {name}", TResource)
// @armResourceCreateOrUpdateCustom(TResource)
// @put
// op ArmResourceCreateOrUpdateSync201<
//   TResource extends ArmResource,
//   TBaseParameters = BaseParameters<TResource>
// >(
//   ...ResourceInstanceParametersCustom<TResource, TBaseParameters>,

//   @doc("Resource create parameters.")
//   @body
//   body: TResource
// ): ArmResponse<TResource> ;

// alias ArmTagsPatchAsync<
//   TResource extends ArmResource,
//   TProperties extends object,
//   TBaseParameters = BaseParameters<TResource>
// > = ArmCustomPatchAsync<TResource, TagsUpdateModel<TResource>, TBaseParameters>;

// alias ArmResourcePatchAsync<
//   TResource extends ArmResource,
//   TProperties extends object,
//   TBaseParameters = BaseParameters<TResource>
// > = ArmCustomPatchAsync<TResource, ResourceUpdateModel<TResource, TProperties>, TBaseParameters>;

// @autoRoute
// @doc("Update a {name}", TResource)
// @extension("x-ms-long-running-operation", true)
// @extension(
//   "x-ms-long-running-operation-options",
//   {
//     "final-state-via": "location",
//   }
// )
// @armResourceUpdate(TResource)
// @patch
// op ArmCustomPatchAsync<
//   TResource extends ArmResource,
//   TPatchModel extends object = TagsUpdateModel<TResource>,
//   TBaseParameters = BaseParameters<TResource>
// >(
//   ...ResourceInstanceParametersCustom<TResource, TBaseParameters>,

//   @doc("The resource properties to be updated.")
//   @body
//   body: TPatchModel
// ): ArmResponse<TResource> | ArmAcceptedResponse<"Resource update request accepted."> ;

// alias ArmTagsPatchSync<
//   TResource extends ArmResource,
//   TBaseParameters = BaseParameters<TResource>
// > = ArmCustomPatchSync<TResource, TagsUpdateModel<TResource>, TBaseParameters>;

// alias ArmResourcePatchSync<
//   TResource extends ArmResource,
//   TProperties extends object,
//   TBaseParameters = BaseParameters<TResource>
// > = ArmCustomPatchSync<TResource, ResourceUpdateModel<TResource, TProperties>, TBaseParameters>;

// @autoRoute
// @doc("Update a {name}", TResource)
// @armResourceUpdate(TResource)
// @patch
// op ArmCustomPatchSync<
//   TResource extends ArmResource,
//   TPatchModel extends object = TagsUpdateModel<TResource>,
//   TBaseParameters = BaseParameters<TResource>
// >(
//   ...ResourceInstanceParametersCustom<TResource, TBaseParameters>,

//   @doc("The resource properties to be updated.")
//   @body
//   body: TPatchModel
// ): ArmResponse<TResource> ;

// @autoRoute
// @doc("Delete a {name}", TResource)
// @extension("x-ms-long-running-operation", true)
// @extension(
//   "x-ms-long-running-operation-options",
//   {
//     "final-state-via": "location",
//   }
// )
// @armResourceDelete(TResource)
// @delete
// op ArmResourceDeleteAsync<
//   TResource extends ArmResource,
//   TBaseParameters = BaseParameters<TResource>
// >(...ResourceInstanceParametersCustom<TResource, TBaseParameters>):
//   | ArmDeleteAcceptedResponse | ArmDeletedNoContentResponse
//   ;

// @autoRoute
// @doc("Delete a {name}", TResource)
// @armResourceDelete(TResource)
// @delete
// op ArmResourceDeleteSync<
//   TResource extends ArmResource,
//   TBaseParameters = BaseParameters<TResource>
// >(
//   ...ResourceInstanceParametersCustom<TResource, TBaseParameters>
// ): ArmDeletedResponse | ArmDeletedNoContentResponse ;

// @autoRoute
// @extension("x-ms-long-running-operation", true)
// @extension(
//   "x-ms-long-running-operation-options",
//   {
//     "final-state-via": "location",
//   }
// )
// @armResourceAction(TResource)
// @post
// op ArmResourceActionAsync<
//   TResource extends ArmResource,
//   TRequest extends object,
//   TResponse extends object,
//   TBaseParameters = BaseParameters<TResource>
// >(
//   ...ResourceInstanceParametersCustom<TResource, TBaseParameters>,

//   @doc("The content of the action request")
//   @body
//   body: TRequest
// ): ArmResponse<TResponse> | ArmAcceptedResponse ;

// @autoRoute
// @armResourceAction(TResource)
// @post
// op ArmResourceActionSync<
//   TResource extends ArmResource,
//   TRequest extends object,
//   TResponse extends object,
//   TBaseParameters = BaseParameters<TResource>
// >(
//   ...ResourceInstanceParametersCustom<TResource, TBaseParameters>,

//   @doc("The content of the action request")
//   @body
//   body: TRequest
// ): ArmResponse<TResponse> ;

// @autoRoute
// @extension("x-ms-long-running-operation", true)
// @extension(
//   "x-ms-long-running-operation-options",
//   {
//     "final-state-via": "location",
//   }
// )
// @armResourceAction(TResource)
// @post
// op ArmResourceActionNoContentAsync<
//   TResource extends ArmResource,
//   TRequest extends object,
//   TBaseParameters = BaseParameters<TResource>
// >(
//   ...ResourceInstanceParametersCustom<TResource, TBaseParameters>,

//   @doc("The content of the action request")
//   @body
//   body: TRequest
// ):  ArmAcceptedResponse ;

// @autoRoute
// @extension("x-ms-long-running-operation", true)
// @extension(
//   "x-ms-long-running-operation-options",
//   {
//     "final-state-via": "location",
//   }
// )
// @armResourceAction(TResource)
// @post
// op ArmResourceActionNoContentAsyncMetaDataBody<
//   TResource extends ArmResource,
//   TRequest extends object,
//   TBaseParameters = BaseParameters<TResource>
// >(
//   ...ResourceInstanceParametersCustom<TResource, TBaseParameters>,

//   @doc("The content of the action request")
//   @body
//   metaData: TRequest
// ):  ArmAcceptedResponse  |ErrorResponse;;

/**
 * A long-running resource action.
 * @template TResource The resource being acted upon
 * @template TRequest The request model for the action
 * @template TResponse The response model for the action
 * @template TBaseParameters Optional. Allows overriding the parameters for the operation
 */
@autoRoute
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "location",
  }
)
@armResourceAction(TResource)
@post
op ArmResourceActionNoContentAsyncMetaDataBody<
  TResource extends ArmResource,
  TRequest extends object,
  TResponse extends object,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("The content of the action request")
  @body
  metaData: TRequest
): ArmAcceptedLroResponse | ArmResponse<TResponse> | ErrorResponse;

// @autoRoute
// @armResourceAction(TResource)
// @post
// op ArmResourceActionNoContentSync<
//   TResource extends ArmResource,
//   TRequest extends object,
//   TBaseParameters = BaseParameters<TResource>
// >(
//   ...ResourceInstanceParametersCustom<TResource, TBaseParameters>,

//   @doc("The content of the action request")
//   @body
//   body: TRequest
// ): ArmNoContentResponse<"Action completed successfully."> ;

/**
 * The dynamic parameters of a resource instance - pass in the proper base type to indicate
 * where the resource is based.  The default is in a resource group
 */
model ResourceInstanceParametersCustom<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
> {
  ...TBaseParameters;
  ...ProviderNamespace<TResource>;
  ...KeysOf<TResource>;
}