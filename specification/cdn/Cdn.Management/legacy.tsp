using Http;
using Rest;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager.Private;

namespace Azure.ResourceManager.CustomLegacy;

/**
 * Synchronous PUT operation for Azure Resource Manager resources
 * @template Resource the resource being created or replaced
 * @template BaseParameters Optional. Allows overriding the operation parameters
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Response Optional. The success response for the createOrUpdate operation
 * @template Error Optional. The error response, if non-standard.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@doc("Create a {name}", Resource)
@armResourceCreateOrUpdate(Resource)
@Private.enforceConstraint(Resource, Foundations.Resource)
@put
op CreateOrUpdateWithoutBodyAsync<
  Resource extends Foundations.SimpleResource,
  BaseParameters = DefaultBaseParameters<Resource>,
  Parameters extends {} = {},
  Response extends {} = ArmResourceUpdatedResponse<Resource> | ArmResourceCreatedSyncResponse<Resource>,
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
