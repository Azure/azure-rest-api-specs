import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SBNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceBus;
@doc("Single item in List or Get Migration Config operation")
@parentResource(SBNamespace)
model MigrationConfigProperty
  is ProxyResource<MigrationConfigPropertiesProperties> {
  @doc("The configuration name. Should always be \"$default\".")
  @path
  @key("configName")
  @segment("migrationConfigurations")
  name: MigrationConfigurationName;
}

@armResourceOperations
interface MigrationConfigProperties {
  @doc("Retrieves Migration Config")
  get is ArmResourceRead<MigrationConfigProperty>;
  @doc("Creates Migration configuration and starts migration of entities from Standard to Premium namespace")
  createAndStartMigration is ArmResourceCreateOrUpdateAsync<MigrationConfigProperty>;
  @doc("Deletes a MigrationConfiguration")
  delete is ArmResourceDeleteSync<MigrationConfigProperty>;
  @doc("Gets all migrationConfigurations")
  list is ArmResourceListByParent<MigrationConfigProperty>;
  @doc("This operation Completes Migration of entities by pointing the connection strings to Premium namespace and any entities created after the operation will be under Premium Namespace. CompleteMigration operation will fail when entity migration is in-progress.")
  completeMigration is ArmResourceActionSync<MigrationConfigProperty, {}, {}>;
  @doc("This operation reverts Migration")
  revert is ArmResourceActionSync<MigrationConfigProperty, {}, {}>;
}
