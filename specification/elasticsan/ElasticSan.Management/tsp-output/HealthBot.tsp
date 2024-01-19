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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a HealthBot.")
  @operationId("Bots_Get")
  get is ArmResourceRead<HealthBot>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a new Azure Health Bot.")
  @operationId("Bots_Create")
  create is ArmResourceCreateOrUpdateAsync<
    HealthBot,
    BaseParameters<HealthBot>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Patch a HealthBot.")
  @operationId("Bots_Update")
  update is ArmCustomPatchSync<HealthBot, HealthBotUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a HealthBot.")
  @operationId("Bots_Delete")
  delete is ArmResourceDeleteAsync<HealthBot>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns all the resources of a particular type belonging to a resource group")
  @operationId("Bots_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<HealthBot>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns all the resources of a particular type belonging to a subscription.")
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
