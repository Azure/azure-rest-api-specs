import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Bot.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a Connection Setting registration for a Bot Service")
  @operationId("BotConnection_Get")
  get is ArmResourceRead<ConnectionSetting>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Register a new Auth Connection for a Bot Service")
  @operationId("BotConnection_Create")
  create is ArmResourceCreateOrReplaceSync<ConnectionSetting>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates a Connection Setting registration for a Bot Service")
  @operationId("BotConnection_Update")
  update is ArmCustomPatchSync<ConnectionSetting, ConnectionSetting>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a Connection Setting registration for a Bot Service")
  @operationId("BotConnection_Delete")
  delete is ArmResourceDeleteSync<ConnectionSetting>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns all the Connection Settings registered to a particular BotService resource")
  @operationId("BotConnection_ListByBotService")
  listByBotService is ArmResourceListByParent<ConnectionSetting>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the available Service Providers for creating Connection Settings")
  @operationId("BotConnection_ListServiceProviders")
  listServiceProviders is ArmListBySubscription<ConnectionSetting>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a Connection Setting registration for a Bot Service")
  @operationId("BotConnection_ListWithSecrets")
  listWithSecrets is ArmResourceActionSync<
    ConnectionSetting,
    void,
    ConnectionSetting
  >;
}

@@projectedName(ConnectionSettings.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(ConnectionSettings.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConnectionSettings.create::parameters.resource,
  "The parameters to provide for creating the Connection Setting."
);
@@projectedName(ConnectionSettings.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ConnectionSettings.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConnectionSettings.update::parameters.properties,
  "The parameters to provide for updating the Connection Setting."
);
