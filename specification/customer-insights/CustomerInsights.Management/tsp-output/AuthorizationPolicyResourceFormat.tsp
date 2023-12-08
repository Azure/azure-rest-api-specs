import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CustomerInsights;
@doc("The authorization policy resource format.")
@parentResource(Hub)
model AuthorizationPolicyResourceFormat is ProxyResource<AuthorizationPolicy> {
  @doc("The name of the policy.")
  @path
  @key("authorizationPolicyName")
  @segment("authorizationPolicies")
  name: string;
}

@armResourceOperations
interface AuthorizationPolicyResourceFormats {
  @doc("Gets an authorization policy in the hub.")
  get is ArmResourceRead<AuthorizationPolicyResourceFormat>;
  @doc("Creates an authorization policy or updates an existing authorization policy.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AuthorizationPolicyResourceFormat>;
  @doc("Gets all the authorization policies in a specified hub.")
  listByHub is ArmResourceListByParent<AuthorizationPolicyResourceFormat>;
  @doc("Regenerates the primary policy key of the specified authorization policy.")
  regeneratePrimaryKey is ArmResourceActionSync<
    AuthorizationPolicyResourceFormat,
    {},
    AuthorizationPolicy
  >;
  @doc("Regenerates the secondary policy key of the specified authorization policy.")
  regenerateSecondaryKey is ArmResourceActionSync<
    AuthorizationPolicyResourceFormat,
    {},
    AuthorizationPolicy
  >;
}
