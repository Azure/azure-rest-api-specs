import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Cdn;
@doc("SecurityPolicy association for AzureFrontDoor profile")
@parentResource(Profile)
model FrontDoorSecurityPolicy is ProxyResource<SecurityPolicyDetails> {
  @doc("Name of the security policy under the profile.")
  @key("securityPolicyName")
  @segment("securityPolicies")
  name: string;
}

@armResourceOperations
interface FrontDoorSecurityPolicies {
  @doc("Gets an existing security policy within a profile.")
  get is ArmResourceRead<FrontDoorSecurityPolicy>;
  @doc("Creates a new security policy within the specified profile.")
  create is ArmResourceCreateOrUpdateAsync<FrontDoorSecurityPolicy>;
  @doc("Updates an existing security policy within a profile.")
  patch is ArmCustomPatchAsync<
    FrontDoorSecurityPolicy,
    SecurityPolicyUpdateParameters
  >;
  @doc("Deletes an existing security policy within profile.")
  delete is ArmResourceDeleteAsync<FrontDoorSecurityPolicy>;
  @doc("Lists security policies associated with the profile")
  listByProfile is ArmResourceListByParent<FrontDoorSecurityPolicy>;
}
