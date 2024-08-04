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
/**
 * Single item in List or Get Alias(Disaster Recovery configuration) operation
 */
@parentResource(EventHubsNamespace)
model EventHubsDisasterRecovery
  is ProxyResource<ArmDisasterRecoveryProperties> {
  /**
   * The Disaster Recovery configuration name
   */
  @maxLength(50)
  @minLength(1)
  @path
  @key("alias")
  @segment("disasterRecoveryConfigs")
  name: string;
}

@armResourceOperations
interface EventHubsDisasterRecoveries {
  /**
   * Retrieves Alias(Disaster Recovery configuration) for primary or secondary namespace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DisasterRecoveryConfigs_Get")
  get is ArmResourceRead<EventHubsDisasterRecovery>;

  /**
   * Creates or updates a new Alias(Disaster Recovery configuration)
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DisasterRecoveryConfigs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<EventHubsDisasterRecovery>;

  /**
   * Deletes an Alias(Disaster Recovery configuration)
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DisasterRecoveryConfigs_Delete")
  delete is ArmResourceDeleteSync<EventHubsDisasterRecovery>;

  /**
   * Gets all Alias(Disaster Recovery configurations)
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DisasterRecoveryConfigs_List")
  list is ArmResourceListByParent<EventHubsDisasterRecovery>;

  /**
   * This operation disables the Disaster Recovery and stops replicating changes from primary to secondary namespaces
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DisasterRecoveryConfigs_BreakPairing")
  breakPairing is ArmResourceActionSync<EventHubsDisasterRecovery, void, void>;

  /**
   * Invokes GEO DR failover and reconfigure the alias to point to the secondary namespace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
