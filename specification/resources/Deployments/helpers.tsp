import "@typespec/rest";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.Resources.Deployments;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "this is a template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "this is a template"
@post
@returnsDoc("Azure operation completed successfully.")
op ArmActionSync<
  TRequest extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model,
  Parameters extends {} = {},
  Error extends {} = ErrorResponse
>(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Parameters,

  @doc("The content of the action request")
  @body
  body: TRequest,
): ArmResponse<TResponse> | ErrorResponse;