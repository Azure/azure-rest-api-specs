import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthBot;
/**
 * Azure Health Bot resource definition
 */
model HealthBot is TrackedResource<HealthBotProperties> {
  /**
   * The name of the Bot resource.
   */
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
  /**
   * Get a HealthBot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Bots_Get")
  get is ArmResourceRead<HealthBot>;

  /**
   * Create a new Azure Health Bot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Bots_Create")
  create is ArmResourceCreateOrReplaceAsync<
    HealthBot,
    BaseParameters<HealthBot>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch a HealthBot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Bots_Update")
  update is ArmCustomPatchSync<HealthBot, HealthBotUpdateParameters>;

  /**
   * Delete a HealthBot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Bots_Delete")
  delete is ArmResourceDeleteAsync<HealthBot>;

  /**
   * Returns all the resources of a particular type belonging to a resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Bots_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<HealthBot>;

  /**
   * Returns all the resources of a particular type belonging to a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Bots_List")
  list is ArmListBySubscription<HealthBot>;
}

@@projectedName(HealthBots.create::parameters.resource, "json", "parameters");
@@extension(HealthBots.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(HealthBots.create::parameters.resource,
  "The parameters to provide for the created Azure Health Bot."
);
@@projectedName(HealthBots.update::parameters.properties, "json", "parameters");
@@extension(HealthBots.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(HealthBots.update::parameters.properties,
  "The parameters to provide for the required Azure Health Bot."
);
