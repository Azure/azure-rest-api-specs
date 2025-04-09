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
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,
  ...Parameters,
  @bodyRoot body?: Request,
): ArmAcceptedLroResponse<"Resource operation accepted.", LroHeaders> | Error;
