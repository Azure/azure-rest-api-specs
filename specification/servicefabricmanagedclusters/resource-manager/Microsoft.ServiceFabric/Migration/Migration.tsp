import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ServiceFabric;

/**
 * Describes the migration of a classic Service Fabric cluster to a Service Fabric managed cluster.
 */
model Migration is Azure.ResourceManager.TrackedResource<MigrationProperties> {
  ...ResourceNameParameter<
    Resource = Migration,
    KeyName = "migrationName",
    SegmentName = "migrations",
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9-_]{0,62}[a-zA-Z0-9])?$"
  >;
}

@armResourceOperations
interface Migrations {
  /**
   * Get a Service Fabric migration resource.
   */
  get is ArmResourceRead<Migration>;

  /**
   * Create or update a Service Fabric migration resource. The source cluster, the target cluster, and
   * the set of node types cannot be changed after the migration is created.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Migration>;

  /**
   * Update the tags of a Service Fabric migration resource.
   */
  update is ArmTagsPatchAsync<Migration>;

  /**
   * Delete a Service Fabric migration resource. The migration must be in the NotStarted, Succeeded, or
   * RolledBack state.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Migration>;

  /**
   * Gets all Service Fabric migration resources in the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Migration>;

  /**
   * Gets all Service Fabric migration resources in the specified subscription.
   */
  listBySubscription is ArmListBySubscription<Migration>;

  /**
   * Start a migration that was created with the Manual start mode. The migration must be in the
   * NotStarted state and provisioning must have succeeded.
   */
  start is ArmResourceActionAsync<
    Migration,
    void,
    Migration,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Migration>
  >;

  /**
   * Roll back a migration, undoing the stages that already ran. The migration must be in the
   * InProgress, Failed, or RollingBack state.
   */
  rollback is ArmResourceActionAsync<
    Migration,
    void,
    Migration,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Migration>
  >;
}
