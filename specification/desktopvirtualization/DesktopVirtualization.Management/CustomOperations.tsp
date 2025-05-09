import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;

alias OptionalBody<Body extends {}> = {
  /** The resource properties to be updated */
  @bodyRoot body?: Body;
};

/**
 * A resource update using a custom PATCH payload (synchronous)
 * @template Resource the resource being patched
 * @template PatchModel The input model for the PATCH request
 * @template BaseParameters Optional. Allows overriding the operation parameters
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Response Optional. The success response for the patch operation
 * @template Error Optional. The error response, if non-standard.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "template"
@autoRoute
@doc("Update a {name}", Resource)
@armResourceUpdate(Resource)
@patch(#{ implicitOptionality: true })
op ArmCustomPatchSync<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  PatchModel extends TypeSpec.Reflection.Model = Azure.ResourceManager.Foundations.TagsUpdateModel<Resource>,
  BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<Resource>,
  Error extends {} = ErrorResponse,
  Request extends {} = {
    /** The resource properties to be updated */
    @bodyRoot body: PatchModel;
  },
  EndParameters extends {} = {}
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,
  ...Parameters,
  ...Request,
  ...EndParameters,
): Response | Error;

/**
 * A resource update using a custom PATCH payload (synchronous)
 * @template Resource the resource being patched
 * @template PatchModel The input model for the PATCH request
 * @template BaseParameters Optional. Allows overriding the operation parameters
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Response Optional. The success response for the patch operation
 * @template Error Optional. The error response, if non-standard.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "template"
@autoRoute
@doc("Update a {name}", Resource)
@armResourceUpdate(Resource)
@patch(#{ implicitOptionality: true })
op ArmCustomPatchAsync<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  PatchModel extends TypeSpec.Reflection.Model = Azure.ResourceManager.Foundations.TagsUpdateModel<Resource>,
  BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
    Resource,
    string
  > &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<Resource> | ArmAcceptedLroResponse<
    "Resource update request accepted.",
    LroHeaders
  >,
  Error extends {} = ErrorResponse,
  Request extends {} = {
    /** The resource properties to be updated */
    @bodyRoot body: PatchModel;
  },
  EndParameters extends {} = {}
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,
  ...Parameters,
  ...Request,
  ...EndParameters,
): Response | Error;

/**
 * A synchronous resource action.
 * @template Resource The resource being acted upon
 * @template Request The request model for the action
 * @template Response The response model for the action
 * @template BaseParameters Optional. Allows overriding the parameters for the operation
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Error Optional. The error response, if non-standard.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "template"
@autoRoute
@armResourceAction(Azure.ResourceManager.Foundations.Resource)
@post
@returnsDoc("Azure operation completed successfully.")
op ArmResourceActionSync<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Request extends TypeSpec.Reflection.Model | void,
  Response extends TypeSpec.Reflection.Model | void,
  BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>,
  Parameters extends {} = {},
  Error extends {} = ErrorResponse,
  RequestBody extends {} = {
    /** The content of the action request */
    @bodyRoot
    body: Request;
  },
  EndParameters extends {} = {}
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,
  ...Parameters,
  ...RequestBody,
  ...EndParameters,
): Response | Error;
