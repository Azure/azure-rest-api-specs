using Http;
using Rest;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager.Private;

namespace Azure.ResourceManager.CustomLegacy;

/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template Resource the resource being created or updated
 * @template BaseParameters Optional. Allows overriding the operation parameters
 * @template LroHeaders Optional.  Allows overriding the lro headers returned on resource create
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Response Optional. The success response for the createOrUpdate operation
 * @template Error Optional. The error response, if non-standard.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage"
@autoRoute
@doc("Create a {name}", Resource)
@armResourceCreateOrUpdate(Resource)
@Private.enforceConstraint(Resource, Foundations.Resource)
@Azure.Core.Foundations.Private.defaultFinalStateVia(#[
  "location",
  "azure-async-operation"
])
@put
op CreateOrUpdateWithoutBodyAsync<
  Resource extends Foundations.SimpleResource,
  BaseParameters = DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmAsyncOperationHeader<FinalResult = Resource> &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Response extends {} = ArmResourceUpdatedResponse<Resource> | ArmResourceCreatedResponse<
    Resource,
    LroHeaders
  >,
  Error extends {} = ErrorResponse
> is ArmCreateOperation<
  ResourceInstanceParameters<Resource, BaseParameters> & Parameters,
  Resource,
  Response,
  Error
>;

/**
 * @dev The base template for Azure Resource Manager PUT Operations.
 * @template HttpParameters The parameter object for the operation.
 * @template BodyParameter The body parameter
 * @template Response The response or union of responses for success.
 * @template ErrorResponse The error response.
 */
op ArmCreateOperation<
  HttpParameters extends {},
  BodyParameter extends {},
  Response extends {},
  ErrorResponse extends {}
>(...HttpParameters): Response | ErrorResponse;

/**
 * A resource list operation, at the scope of the resource's parent
 * @template Resource the resource being patched
 * @template BaseParameters Optional. Allows overriding the operation parameters
 * @template ParentName Optional. The name of the parent resource
 * @template ParentFriendlyName Optional. The friendly name of the parent resource
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Response Optional. The success response for the list operation
 * @template Error Optional. The error response, if non-standard.
 */
@get
@autoRoute
@listsResource(Resource)
@segmentOf(Resource)
@Private.armRenameListByOperation(
  Resource,
  ParentName,
  ParentFriendlyName,
  false
) // This must come before @armResourceList!
@armResourceList(Resource)
@Private.enforceConstraint(Resource, Foundations.Resource)
op ArmResourceListByParent<
  Resource extends Foundations.SimpleResource,
  BaseParameters = DefaultBaseParameters<Resource>,
  ParentName extends valueof string = "",
  ParentFriendlyName extends valueof string = "",
  Parameters extends {} = {},
  Response extends {} = ArmResponse<ResourceListResult<Resource>>,
  Error extends {} = ErrorResponse
> is ArmReadOperation<
  ResourceParentParameters<Resource, BaseParameters> & Parameters,
  Response,
  Error
>;

/**
 * @dev The base template for Azure Resource Manager GET and HEAD Operations.
 * @template Parameters The parameter object for the operation.
 * @template Response The response or union of responses for success.
 * @template ErrorResponse The error response.
 */
op ArmReadOperation<
  Parameters extends {},
  Response extends {},
  ErrorResponse extends {}
>(...Parameters): Response | ErrorResponse;
