import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.Resources.DeploymentStacks;

/**
 * The management group name path parameter.
 */
model ManagementGroupIdParameter {
  /** The name of the management group. The name is case insensitive. */
  @path
  @minLength(1)
  @maxLength(90)
  @segment("providers/Microsoft.Management/managementGroups")
  managementGroupId: string;
}

model ManagementGroupIdBaseParameters
  is Azure.ResourceManager.Foundations.TenantBaseParameters {
  ...ManagementGroupIdParameter;
}

@doc("Resource validation failed.")
// TODO: This property isn't being output in the open API definition. Not sure if it's obsolete now. It was explicitly set on the 400 responses to `false` and I believe it influences SDK code generation by returning a response vs throwing an exception.
//@extension("x-ms-error-response", false)
model ValidationBadRequestResponse<TBody> {
  ...BadRequestResponse;

  @doc("The body type of the operation request or response.")
  @bodyRoot
  body: TBody;
}
