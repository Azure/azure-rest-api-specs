import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;

/**
 * @dev A long-running resource CreateOrUpdate (PUT)
 * @template Resource the resource being created or replaced
 * @template BaseParameters Optional. Allows overriding the operation parameters
 * @template LroHeaders Optional.  Allows overriding the lro headers returned on resource create
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Response Optional. The success response for the createOrReplace operation
 * @template Error Optional. The error response, if non-standard.
 */
@Azure.ResourceManager.Private.enforceConstraint(Resource, Foundations.Resource)
op CustomArmResourceCreateOrReplaceAsync<
  Resource extends Foundations.SimpleResource,
  BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmAsyncOperationHeader<FinalResult = Resource> &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Response extends {} = ArmResourceUpdatedResponse<Resource> | ArmResourceCreatedResponse<
    Resource,
    LroHeaders
  >,
  Error extends {} = ErrorResponse
> is CustomArmResourceCreateOrUpdateAsync<
  Resource,
  BaseParameters,
  LroHeaders,
  Parameters,
  Response,
  Error
>;

/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template Resource the resource being created or updated
 * @template BaseParameters Optional. Allows overriding the operation parameters
 * @template LroHeaders Optional.  Allows overriding the lro headers returned on resource create
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Response Optional. The success response for the createOrUpdate operation
 * @template Error Optional. The error response, if non-standard.
 */
@autoRoute
@doc("Create a {name}", Resource)
@armResourceCreateOrUpdate(Resource)
@Azure.ResourceManager.Private.enforceConstraint(Resource, Foundations.Resource)
@Azure.Core.Foundations.Private.defaultFinalStateVia(#[
  "location",
  "azure-async-operation"
])
@put
op CustomArmResourceCreateOrUpdateAsync<
  Resource extends Foundations.SimpleResource,
  BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmAsyncOperationHeader<FinalResult = Resource> &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Response extends {} = ArmResourceUpdatedResponse<Resource> | ArmResourceCreatedResponse<
    Resource,
    LroHeaders
  >,
  Error extends {} = ErrorResponse
> is CustomArmCreateOperation<
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
op CustomArmCreateOperation<
  HttpParameters extends {},
  BodyParameter extends {},
  Response extends {},
  ErrorResponse extends {}
>(...HttpParameters): Response | ErrorResponse;
