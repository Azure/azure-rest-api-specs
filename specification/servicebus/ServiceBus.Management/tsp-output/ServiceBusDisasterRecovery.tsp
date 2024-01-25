import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
/**
 * Single item in List or Get Alias(Disaster Recovery configuration) operation
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ServiceBusNamespace)
@Azure.ResourceManager.Private.armResourceInternal(
  ArmDisasterRecoveryProperties
)
@includeInapplicableMetadataInPayload(false)
model ServiceBusDisasterRecovery extends ProxyResource {
  /**
   * The Disaster Recovery configuration name
   */
  @maxLength(50)
  @minLength(1)
  @path
  @key("alias")
  @segment("disasterRecoveryConfigs")
  name: string;

  /**
   * Properties required to the Create Or Update Alias(Disaster Recovery configurations)
   */
  @extension("x-ms-client-flatten", true)
  properties?: ArmDisasterRecoveryProperties;
}

@armResourceOperations
interface ServiceBusDisasterRecoveries {
  /**
   * Retrieves Alias(Disaster Recovery configuration) for primary or secondary namespace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DisasterRecoveryConfigs_Get")
  get is ArmResourceRead<ServiceBusDisasterRecovery>;

  /**
   * Creates or updates a new Alias(Disaster Recovery configuration)
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DisasterRecoveryConfigs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceBusDisasterRecovery>;

  /**
   * Deletes an Alias(Disaster Recovery configuration)
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DisasterRecoveryConfigs_Delete")
  delete is ArmResourceDeleteSync<ServiceBusDisasterRecovery>;

  /**
   * Gets all Alias(Disaster Recovery configurations)
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DisasterRecoveryConfigs_List")
  list is ArmResourceListByParent<ServiceBusDisasterRecovery>;

  /**
   * This operation disables the Disaster Recovery and stops replicating changes from primary to secondary namespaces
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DisasterRecoveryConfigs_BreakPairing")
  breakPairing is ArmResourceActionSync<ServiceBusDisasterRecovery, void, void>;

  /**
   * Invokes GEO DR failover and reconfigure the alias to point to the secondary namespace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DisasterRecoveryConfigs_FailOver")
  failOver is ArmResourceActionSync<
    ServiceBusDisasterRecovery,
    FailoverProperties,
    void
  >;
}

@@projectedName(ServiceBusDisasterRecoveries.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServiceBusDisasterRecoveries.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceBusDisasterRecoveries.createOrUpdate::parameters.resource,
  "Parameters required to create an Alias(Disaster Recovery configuration)"
);
@@projectedName(ServiceBusDisasterRecoveries.failOver::parameters.body,
  "json",
  "parameters"
);
@@extension(ServiceBusDisasterRecoveries.failOver::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceBusDisasterRecoveries.failOver::parameters.body,
  "Parameters required to create an Alias(Disaster Recovery configuration)"
);
