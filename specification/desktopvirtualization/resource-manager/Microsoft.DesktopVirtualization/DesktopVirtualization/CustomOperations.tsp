import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;

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
@patch(#{ implicitOptionality: false })
op ArmCustomPatchSyncWithOptionalBody<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  PatchModel extends TypeSpec.Reflection.Model = Azure.ResourceManager.Foundations.TagsUpdateModel<Resource>,
  BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<Resource>,
  Error extends {} = ErrorResponse
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,
  ...Parameters,

  /** The resource properties to be updated */
  @bodyRoot body?: PatchModel,
): Response | Error;

/**
 * A resource update using a custom PATCH payload (asynchronous)
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
@patch(#{ implicitOptionality: false })
op ArmCustomPatchAsyncWithOptionalBody<
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
  Error extends {} = ErrorResponse
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,
  ...Parameters,

  /** The resource properties to be updated */
  @bodyRoot body?: PatchModel,
): Response | Error;
