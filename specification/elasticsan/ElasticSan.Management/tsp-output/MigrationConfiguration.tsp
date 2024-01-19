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
@doc("Single item in List or Get Migration Config operation")
@parentResource(ServiceBusNamespace)
model MigrationConfiguration
  is ProxyResource<MigrationConfigPropertiesProperties> {
  @doc("The configuration name. Should always be \"$default\".")
  @path
  @key("configName")
  @segment("migrationConfigurations")
  name: MigrationConfigurationName;
}

@armResourceOperations
interface MigrationConfigurations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieves Migration Config")
  @operationId("MigrationConfigs_Get")
  get is ArmResourceRead<MigrationConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates Migration configuration and starts migration of entities from Standard to Premium namespace")
  @operationId("MigrationConfigs_CreateAndStartMigration")
  createAndStartMigration is ArmResourceCreateOrUpdateAsync<MigrationConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a MigrationConfiguration")
  @operationId("MigrationConfigs_Delete")
  delete is ArmResourceDeleteSync<MigrationConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all migrationConfigurations")
  @operationId("MigrationConfigs_List")
  list is ArmResourceListByParent<MigrationConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This operation Completes Migration of entities by pointing the connection strings to Premium namespace and any entities created after the operation will be under Premium Namespace. CompleteMigration operation will fail when entity migration is in-progress.")
  @operationId("MigrationConfigs_CompleteMigration")
  completeMigration is ArmResourceActionSync<
    MigrationConfiguration,
    void,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This operation reverts Migration")
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
