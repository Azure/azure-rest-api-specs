import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
using Http;
using Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

/**
 * @dev A long-running resource action that returns no content.
 * @template Resource The resource being acted upon
 * @template Request The request model for the action
 * @template BaseParameters Optional. Allows overriding the parameters for the operation
 * @template Headers Optional. Allows overriding the headers returned in the Accepted response
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Error Optional. The error response, if non-standard.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" ""
op CustomizedArmResourceActionNoResponseContentAsync<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Request extends TypeSpec.Reflection.Model | void,
  BaseParameters extends TypeSpec.Reflection.Model = DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
    void,
    string
  > &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Error extends {} = ErrorResponse
> is CustomizedArmResourceActionAsyncBase<
  Resource,
  Request,
  ArmAcceptedLroResponse<"Resource operation accepted.", LroHeaders>,
  BaseParameters,
  Parameters,
  Error
>;

/**
 * A long-running resource action.
 * @template Resource The resource being acted upon
 * @template Request The request model for the action
 * @template Response The response type for the action
 * @template BaseParameters Optional. Allows overriding the parameters for the operation
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Error Optional. The error response, if non-standard.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" ""
@autoRoute
@armResourceAction(Resource)
@post
op CustomizedArmResourceActionAsyncBase<
  Resource extends Foundations.Resource,
  Request extends TypeSpec.Reflection.Model | void,
  Response extends TypeSpec.Reflection.Model | void,
  BaseParameters extends TypeSpec.Reflection.Model,
  Parameters extends {} = {},
  Error extends {} = ErrorResponse
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,
  ...Parameters,

  /** The content of the action request */
  @bodyRoot body?: Request,
): Response | Error;
