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
 * Single item in List or Get Migration Config operation
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ServiceBusNamespace)
@Azure.ResourceManager.Private.armResourceInternal(
  MigrationConfigPropertiesProperties
)
@includeInapplicableMetadataInPayload(false)
model MigrationConfiguration extends ProxyResource {
  /**
   * The configuration name. Should always be "$default".
   */
  @path
  @key("configName")
  @segment("migrationConfigurations")
  name: MigrationConfigurationName;

  /**
   * Properties required to the Create Migration Configuration
   */
  @extension("x-ms-client-flatten", true)
  properties?: MigrationConfigPropertiesProperties;
}

@armResourceOperations
interface MigrationConfigurations {
  /**
   * Retrieves Migration Config
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MigrationConfigs_Get")
  get is ArmResourceRead<MigrationConfiguration>;

  /**
   * Creates Migration configuration and starts migration of entities from Standard to Premium namespace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MigrationConfigs_CreateAndStartMigration")
  createAndStartMigration is ArmResourceCreateOrReplaceAsync<MigrationConfiguration>;

  /**
   * Deletes a MigrationConfiguration
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MigrationConfigs_Delete")
  delete is ArmResourceDeleteSync<MigrationConfiguration>;

  /**
   * Gets all migrationConfigurations
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MigrationConfigs_List")
  list is ArmResourceListByParent<MigrationConfiguration>;

  /**
   * This operation Completes Migration of entities by pointing the connection strings to Premium namespace and any entities created after the operation will be under Premium Namespace. CompleteMigration operation will fail when entity migration is in-progress.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MigrationConfigs_CompleteMigration")
  completeMigration is ArmResourceActionSync<
    MigrationConfiguration,
    void,
    void
  >;

  /**
   * This operation reverts Migration
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MigrationConfigs_Revert")
  revert is ArmResourceActionSync<MigrationConfiguration, void, void>;
}

@@projectedName(MigrationConfigurations.createAndStartMigration::parameters.resource,
  "json",
  "parameters"
);
@@extension(MigrationConfigurations.createAndStartMigration::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(MigrationConfigurations.createAndStartMigration::parameters.resource,
  "Parameters required to create Migration Configuration"
);
