import "./operationsCore.tsp";

//namespace Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Autorest;
using Azure.ResourceManager.Foundations;
using Azure.Core.Traits;
using Azure.Core.Traits.Private;

namespace Azure.ResourceManager;
@autoRoute
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    "final-state-via":"location",
  }
)
@armResourceAction(TResource)
@post
@doc("Operation template for creating async arm resource action without body.")
op ArmResourceActionAsyncNoRequestBody<
  TResource extends ArmResource,
  TResponse extends object,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

):   ArmAcceptedResponseWithLocationHeader | ArmResponse<TResponse> | ErrorResponse;


@autoRoute
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    "final-state-via": "location",
  }
)
@armResourceAction(TResource)
@post
op ArmResourceActionNoContentNoBodyAsync<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

): ArmNoContentResponse<"Action completed successfully."> | ArmAcceptedResponseWithLocationHeader | ErrorResponse;

@autoRoute
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    "final-state-via": "location",
  }
)
@armResourceAction(TResource)
@post
op ArmResourceActionNoBodyAsync<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

):  ArmAcceptedResponseWithLocationHeader |  ErrorResponse;


@doc("The response of a {name} list operation.", TResource)
@friendlyName("{name}Collection", TResource)
model ResourceListResultUpdated<TResource extends ArmResource> is Azure.Core.PageUpdated<TResource>;

@get
@autoRoute
@list(TResource)
@segmentOf(TResource)
@armRenameListByOperation(TResource, TParentName, TParentFriendlyName) // This must come before @armResourceList!
@armResourceList(TResource)
op ArmResourceListByParentUpdated<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>,
  TParentName = "",
  TParentFriendlyName = ""
>(
  ...ResourceParentParameters<TResource, TBaseParameters>
): ArmResponse<ResourceListResultUpdated<TResource>> ;

@doc("Ok")
model ArmOkResponse {
  ...OkResponse;
}

@get
@autoRoute
@list(TResource)
@segmentOf(TResource)
@armRenameListByOperation(TResource, TParentName, TParentFriendlyName) // This must come before @armResourceList!
@armResourceList(TResource)
op ArmResourceListByParentUpdatedOk<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>,
  TParentName = "",
  TParentFriendlyName = ""
>(
  ...ResourceParentParameters<TResource, TBaseParameters>
): ArmOkResponse ;

@autoRoute
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    "final-state-via": "location",
  }
)
@armResourceAction(TResource)
@post
op ArmResourceActionAsyncCustomMapRequest<
  TResource extends ArmResource,
  TRequest extends object,
  TResponse extends object,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,
  @doc("The content of the action request")
  @body
  mapRequest: TRequest
):  ArmAcceptedLroResponse | ArmResponse<TResponse> | ErrorResponse ;

@autoRoute
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    "final-state-via": "location",
  }
)
@armResourceAction(TResource)
@post
op ArmResourceActionNoContentAsyncCustomUpdateMachineDepMapStatus<
  TResource extends ArmResource,
  TRequest extends object,
  TResponse extends object,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("The content of the action request")
  @body
  updateMachineDepMapStatus: TRequest
):  ArmAcceptedResponseWithLocationHeader | ArmResponse<TResponse> | ErrorResponse;

@autoRoute
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    "final-state-via": "location",
  }
)
@armResourceAction(TResource)
@post
op ArmResourceActionNoContentAsyncCustomUpdateRunAsAccount<
  TResource extends ArmResource,
  TRequest extends object,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("The content of the action request")
  @body
  updateMachineRunAsAccount: TRequest
):  ArmAcceptedResponseWithLocationHeader ;

@autoRoute
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    "final-state-via": "location",
  }
)
@armResourceAction(TResource)
@post
op ArmResourceActionNoContentAsyncCustomUpdateMachineTags<
  TResource extends ArmResource,
  TRequest extends object,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("The content of the action request")
  @body
  updateMachineTags: TRequest
):  ArmAcceptedResponseWithLocationHeader ;

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "inlining the response with a header does not present a risk"
alias ArmAcceptedResponseWithLocationHeader = ArmAcceptedResponse &
  LocationHeader;

@autoRoute
@doc("Create a {name}", TResource)
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    "final-state-via": "location",
  }
)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdateAsyncCustom<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @body
  body: TResource
):  ArmAcceptedResponseWithLocationHeader  | ArmUpdateResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;

/**
 * The ARM synchronous OK response
 * @template T The contents of the response body
 */
@doc("ARM update operation completed successfully.")
model ArmUpdateResponse<T> {
  ...OkResponse;
  ...Body<T>;
}
@autoRoute
@doc("Create a {name}", TResource)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdateSyncCustom<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @body
  body: TResource
): ArmUpdateResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;

/**
 * A resource CreateOrUpdate (PUT)
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
@autoRoute
@doc("Create a {name}", TResource)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdateSync201<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @body
  body: TResource
): ArmUpdateResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;

@autoRoute
@armResourceAction(TResource)
@post
op ArmResourceActionSyncNoRequestBody<
  TResource extends ArmResource,
  TResponse extends object,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,
): ArmResponse<TResponse> | ErrorResponse;

/**
 * This is the interface that implements the standard ARM operation that returns
 * all supported RP operations. You should have exactly one declaration for each
 * ARM service. It implements
 *   GET "/providers/Microsoft.ContosoProviderHub/operations"
 */
interface OperationsCustom {
  @tag("Operations")
  @autoRoute
  @armUpdateProviderNamespace
  @doc("List the operations for the provider")
  @segment("operations")
  @get
  
  list(
    ...ApiVersionParameter,

    @path
    @segment("providers")
    @doc("The provider namespace (this parameter will not show up in operations).")
    provider: "Microsoft.ThisWillBeReplaced"
  ): ArmResponse<OperationListResult> ;
}

#suppress "@azure-tools/cadl-providerhub/operation-requires-documentation" "This is a library operation."
op OperationCustom<
  TParams,
  TResponse,
  Traits extends object = {},
  TErrorResponse = Azure.Core.Foundations.ErrorResponse
>(
  ...TraitProperties<
    Traits & VersionParameterTrait<ApiVersionParameter>,
    TraitLocation.ApiVersionParameter
  >,
  ...TParams
): ArmDeletedResponse | TResponse ;

/**
 * Represent any structured model.(With properties)
 */
@doc("object model")
model Object {}

