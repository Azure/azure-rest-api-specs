import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";

using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

/**
 * A long-running resource action that returns a different resource type.
 * Uses Location header for polling with `final-state-via: location` pattern.
 *
 * @template Resource The resource being acted upon
 * @template Request The request model for the action
 * @template Response The response model for the action (the final result type)
 * @template BaseParameters Optional. Allows overriding the parameters for the operation
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Custom LRO operation with specific response codes"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for LRO extensions in OpenAPI output"
@autoRoute
@armResourceAction(Resource)
@post
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  #{ `final-state-via`: "location" }
)
op ArmResourceActionAsyncWithLocation<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Request extends TypeSpec.Reflection.Model | void,
  Response extends TypeSpec.Reflection.Model,
  BaseParameters extends TypeSpec.Reflection.Model = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,
  @bodyRoot body?: Request,
):
  | ArmResponse<Response>
  | ArmAcceptedLroResponse<
      "Resource operation accepted.",
      ArmLroLocationHeader<FinalResult = Response> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  | ErrorResponse;

/**
 * A long-running resource action that returns 202 No Content on the initial POST,
 * but the SDK should expect a result body from the Location URL when polling completes.
 * Uses Location header for polling with `final-state-via: location` pattern.
 *
 * Use this when:
 * - The initial POST should return 202 with no body (No Content)
 * - The Location header URL returns the final result body when complete
 *
 * @template Resource The resource being acted upon
 * @template Request The request model for the action (usually void)
 * @template FinalResult The result type returned from the Location URL when complete
 * @template BaseParameters Optional. Allows overriding the parameters for the operation
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Custom LRO operation with specific response codes"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for LRO extensions in OpenAPI output"
@autoRoute
@armResourceAction(Resource)
@post
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  #{ `final-state-via`: "location" }
)
op ArmResourceActionNoContentAsyncWithLocationResult<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Request extends TypeSpec.Reflection.Model | void,
  FinalResult extends TypeSpec.Reflection.Model,
  BaseParameters extends TypeSpec.Reflection.Model = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,
  @bodyRoot body?: Request,
):
  | ArmAcceptedLroResponse<
      "Resource operation accepted.",
      ArmLroLocationHeader<FinalResult = FinalResult> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  | ErrorResponse;

/**
 * A long-running resource action that returns no body on completion (204 No Content).
 * Uses Location header for polling with `final-state-via: location` pattern.
 *
 * Use this when:
 * - The initial POST returns 202 Accepted
 * - The operation completes with 204 No Content (no response body)
 *
 * @template Resource The resource being acted upon
 * @template Request The request model for the action (usually void)
 * @template BaseParameters Optional. Allows overriding the parameters for the operation
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Custom LRO operation with specific response codes"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for LRO extensions in OpenAPI output"
@autoRoute
@armResourceAction(Resource)
@post
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  #{ `final-state-via`: "location" }
)
op ArmResourceActionNoBodyAsyncWithLocation<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Request extends TypeSpec.Reflection.Model | void,
  BaseParameters extends TypeSpec.Reflection.Model = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,
  @bodyRoot body?: Request,
):
  | ArmAcceptedLroResponse<
      "Resource operation accepted.",
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  | {
      @doc("The operation completed successfully with no content.")
      @statusCode
      _: 204;
    }
  | ErrorResponse;
