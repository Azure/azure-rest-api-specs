import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Http;
using Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Private;

/**
 * A long-running resource action.
 * @template Resource The resource being acted upon
 * @template Request The request model for the action
 * @template Response The response type for the action
 * @template BaseParameters Optional. Allows overriding the parameters for the operation
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Error Optional. The error response, if non-standard.
 * @template OptionalRequestBody Optional. Indicates whether the request body is optional.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage"
@autoRoute
@armResourceAction(Resource)
@Azure.ResourceManager.Private.enforceConstraint(Resource, Foundations.Resource)
@post
op ArmResourceActionAsyncCustom<
  Resource extends Foundations.SimpleResource,
  Request,
  Response extends TypeSpec.Reflection.Model | unknown | void,
  BaseParameters extends TypeSpec.Reflection.Model = Foundations.DefaultBaseParameters<Resource>,
  Parameters extends {} = {},
  Error extends {} = ErrorResponse
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,
  ...Parameters,
  ...Request,
): Response | Error;
