import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HealthBot;
@doc("Azure Health Bot resource definition")
model HealthBot is TrackedResource<HealthBotProperties> {
  @doc("The name of the Bot resource.")
  @maxLength(64)
  @minLength(2)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @path
  @key("botName")
  @segment("healthBots")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface HealthBots {
  @doc("Get a HealthBot.")
  get is ArmResourceRead<HealthBot>;
  @doc("Create a new Azure Health Bot.")
  create is ArmResourceCreateOrUpdateAsync<HealthBot>;
  @doc("Patch a HealthBot.")
  update is ArmResourcePatchSync<HealthBot, HealthBotProperties>;
  @doc("Delete a HealthBot.")
  delete is ArmResourceDeleteAsync<HealthBot>;
  @doc("Returns all the resources of a particular type belonging to a resource group")
  listByResourceGroup is ArmResourceListByParent<HealthBot>;
  @doc("Returns all the resources of a particular type belonging to a subscription.")
  list is ArmListBySubscription<HealthBot>;
}
