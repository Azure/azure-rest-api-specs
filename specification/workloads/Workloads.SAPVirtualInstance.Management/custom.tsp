using Http;
using Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

/**
 * A synchronous resource action.
 * @template Resource The resource being acted upon
 * @template Request The request model for the action
 * @template Response The response model for the action
 * @template BaseParameters Optional. Allows overriding the parameters for the operation
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Error Optional. The error response, if non-standard.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Custom template"
// THIS IS TO PROVIDE a temp workaround. The standard ArmResourceXX operations will be expected to support
// ARM virtual resources. Until then, use this custom template
@autoRoute
@armResourceAction(Resource)
@post
@returnsDoc("Azure operation completed successfully.")
op VirtualResourceActionSync<
  Resource extends Foundations.Resource,
  Request extends TypeSpec.Reflection.Model | void,
  Response extends TypeSpec.Reflection.Model | void,
  BaseParameters = DefaultBaseParameters<Resource>,
  Parameters extends {} = {},
  Error extends {} = ErrorResponse
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,
  ...Parameters,

  @doc("The content of the action request")
  @bodyRoot
  body: Request,
): Response | Error;
