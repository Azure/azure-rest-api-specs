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
@doc("Friendly Secret name mapping to the any Secret or secret related information.")
@parentResource(Profile)
model FrontDoorSecret is ProxyResource<SecretDetails> {
  @doc("Name of the Secret under the profile.")
  @key("secretName")
  @segment("secrets")
  name: string;
}

@armResourceOperations
interface FrontDoorSecrets {
  @doc("Gets an existing Secret within a profile.")
  get is ArmResourceRead<FrontDoorSecret>;
  @doc("Creates a new Secret within the specified profile.")
  create is ArmResourceCreateOrUpdateAsync<FrontDoorSecret>;
  @doc("Deletes an existing Secret within profile.")
  delete is ArmResourceDeleteAsync<FrontDoorSecret>;
  @doc("Lists existing AzureFrontDoor secrets.")
  listByProfile is ArmResourceListByParent<FrontDoorSecret>;
}
