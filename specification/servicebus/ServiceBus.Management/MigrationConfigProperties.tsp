import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SBNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ServiceBus;
/**
 * Single item in List or Get Migration Config operation
 */
@parentResource(SBNamespace)
model MigrationConfigProperties
  is Azure.ResourceManager.ProxyResource<MigrationConfigPropertiesProperties> {
  ...ResourceNameParameter<
    Resource = MigrationConfigProperties,
    KeyName = "configName",
    SegmentName = "migrationConfigurations",
    NamePattern = "",
    Type = MigrationConfigurationName
  >;
}

@armResourceOperations
interface MigrationConfigs {
  /**
   * Retrieves Migration Config
   */
  get is ArmResourceRead<MigrationConfigProperties>;

  /**
   * Creates Migration configuration and starts migration of entities from Standard to Premium namespace
   */
  createAndStartMigration is ArmResourceCreateOrReplaceAsync<
    MigrationConfigProperties,
    LroHeaders = ArmLroLocationHeader<FinalResult = MigrationConfigProperties> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a MigrationConfiguration
   */
  delete is ArmResourceDeleteSync<MigrationConfigProperties>;

  /**
   * Gets all migrationConfigurations
   */
  list is ArmResourceListByParent<MigrationConfigProperties>;

  /**
   * This operation Completes Migration of entities by pointing the connection strings to Premium namespace and any entities created after the operation will be under Premium Namespace. CompleteMigration operation will fail when entity migration is in-progress.
   */
  @action("upgrade")
  completeMigration is ArmResourceActionSync<
    MigrationConfigProperties,
    void,
    OkResponse
  >;

  /**
   * This operation reverts Migration
   */
  revert is ArmResourceActionSync<MigrationConfigProperties, void, OkResponse>;
}

@@doc(MigrationConfigProperties.name,
  "The configuration name. Should always be $default."
);
@@doc(MigrationConfigProperties.properties,
  "Properties required to the Create Migration Configuration"
);
@@doc(MigrationConfigs.createAndStartMigration::parameters.resource,
  "Parameters required to create Migration Configuration"
);
