import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EventHubsNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
@doc("Single item in List or Get Alias(Disaster Recovery configuration) operation")
@parentResource(EventHubsNamespace)
model EventHubsDisasterRecovery
  is ProxyResource<ArmDisasterRecoveryProperties> {
  @doc("The Disaster Recovery configuration name")
  @maxLength(50)
  @minLength(1)
  @path
  @key("alias")
  @segment("disasterRecoveryConfigs")
  name: string;
}

@armResourceOperations
interface EventHubsDisasterRecoveries {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieves Alias(Disaster Recovery configuration) for primary or secondary namespace")
  @operationId("DisasterRecoveryConfigs_Get")
  get is ArmResourceRead<EventHubsDisasterRecovery>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a new Alias(Disaster Recovery configuration)")
  @operationId("DisasterRecoveryConfigs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<EventHubsDisasterRecovery>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an Alias(Disaster Recovery configuration)")
  @operationId("DisasterRecoveryConfigs_Delete")
  delete is ArmResourceDeleteSync<EventHubsDisasterRecovery>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all Alias(Disaster Recovery configurations)")
  @operationId("DisasterRecoveryConfigs_List")
  list is ArmResourceListByParent<EventHubsDisasterRecovery>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This operation disables the Disaster Recovery and stops replicating changes from primary to secondary namespaces")
  @operationId("DisasterRecoveryConfigs_BreakPairing")
  breakPairing is ArmResourceActionSync<EventHubsDisasterRecovery, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Invokes GEO DR failover and reconfigure the alias to point to the secondary namespace")
  @operationId("DisasterRecoveryConfigs_FailOver")
  failOver is ArmResourceActionSync<EventHubsDisasterRecovery, void, void>;
}

@@projectedName(EventHubsDisasterRecoveries.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(EventHubsDisasterRecoveries.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(EventHubsDisasterRecoveries.createOrUpdate::parameters.resource,
  "Parameters required to create an Alias(Disaster Recovery configuration)"
);
