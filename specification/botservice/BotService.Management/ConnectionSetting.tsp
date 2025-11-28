import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Bot.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.BotService;
@doc("Bot channel resource definition")
@parentResource(Bot)
model ConnectionSetting is TrackedResource<ConnectionSettingProperties> {
  @doc("The name of the Bot Service Connection Setting resource.")
  @maxLength(64)
  @minLength(2)
  @pattern("^[a-zA-Z0-9][\\sa-zA-Z0-9_.-]*$")
  @path
  @key("connectionName")
  @segment("connections")
  name: string;
}

@armResourceOperations
interface ConnectionSettings {
  @doc("Get a Connection Setting registration for a Bot Service")
  get is ArmResourceRead<ConnectionSetting>;
  @doc("Register a new Auth Connection for a Bot Service")
  create is ArmResourceCreateOrReplaceSync<ConnectionSetting>;
  @doc("Updates a Connection Setting registration for a Bot Service")
  update is ArmResourcePatchSync<
    ConnectionSetting,
    ConnectionSettingProperties
  >;
  @doc("Deletes a Connection Setting registration for a Bot Service")
  delete is ArmResourceDeleteSync<ConnectionSetting>;
  @doc("Returns all the Connection Settings registered to a particular BotService resource")
  listByBotService is ArmResourceListByParent<ConnectionSetting>;
  @doc("Lists the available Service Providers for creating Connection Settings")
  listServiceProviders is ArmListBySubscription<ConnectionSetting>;
  @doc("Get a Connection Setting registration for a Bot Service")
  listWithSecrets is ArmResourceActionSync<
    ConnectionSetting,
    {},
    ConnectionSetting
  >;
}
