import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./../models.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetApp;

/**
 * NetApp elastic backup vault resource
 */
@added(Versions.v2025_09_01_preview)
@parentResource(ElasticAccount)
model ElasticBackupVault is TrackedResource<ElasticBackupVaultProperties> {
  ...ResourceNameParameter<
    Resource = ElasticBackupVault,
    KeyName = "backupVaultName",
    SegmentName = "elasticBackupVaults",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

/**
 * Elastic Backup Vault properties
 */
@added(Versions.v2025_09_01_preview)
model ElasticBackupVaultProperties {
  /**
   * Azure lifecycle management.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;
}

@armResourceOperations
interface ElasticBackupVaults {
  /**
   * Get the Elastic Backup Vault
   */
  @added(Versions.v2025_09_01_preview)
  get is ArmResourceRead<ElasticBackupVault>;

  /**
   * Create or update the specified Elastic Backup Vault in the Elastic NetApp account
   */
  @added(Versions.v2025_09_01_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticBackupVault>;

  /**
   * Patch the specified NetApp Elastic Backup Vault
   */
  @added(Versions.v2025_09_01_preview)
  update is ArmCustomPatchAsync<
    ElasticBackupVault,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ElasticBackupVault,
      ElasticBackupVaultProperties
    >
  >;

  /**
   * Delete the specified Elastic Backup Vault
   */
  @added(Versions.v2025_09_01_preview)
  delete is ArmResourceDeleteWithoutOkAsync<ElasticBackupVault>;
  /**
   * List and describe all Elastic Backup Vaults in the elastic account.
   */
  @added(Versions.v2025_09_01_preview)
  listByElasticAccount is ArmResourceListByParent<ElasticBackupVault>;
}

@@clientName(ElasticBackupVaults.createOrUpdate::parameters.resource, "body");
@@clientName(ElasticBackupVaults.update::parameters.properties, "body");

@@maxLength(ElasticBackupVault.name, 64);
@@minLength(ElasticBackupVault.name, 1);
