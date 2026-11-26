import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./EHNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.EventHub;

/**
 * The migration of an Event Hubs namespace to a new SKU.
 */
@added(Versions.v2026_09_01_preview)
@singleton("default")
@parentResource(EHNamespace)
model NamespaceMigration
  is Azure.ResourceManager.ProxyResource<NamespaceMigrationProperties> {
  ...ResourceNameParameter<
    Resource = NamespaceMigration,
    KeyName = "migrationName",
    SegmentName = "migrations",
    NamePattern = "^default$"
  >;
}

/**
 * The properties of a namespace migration.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The service does not expose a provisioning state for this proxy resource."
@added(Versions.v2026_09_01_preview)
model NamespaceMigrationProperties {
  /**
   * The migration settings.
   */
  migration?: NamespaceMigrationDetails;
}

/**
 * The replication lag of a namespace migration for a single target.
 */
@added(Versions.v2026_09_01_preview)
@parentResource(NamespaceMigration)
model NamespaceMigrationReplicationLag
  is Azure.ResourceManager.ProxyResource<NamespaceMigrationReplicationLagProperties> {
  ...ResourceNameParameter<
    Resource = NamespaceMigrationReplicationLag,
    KeyName = "replicationLagName",
    SegmentName = "replicationLags",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9_.-]{0,127}$"
  >;
}

/**
 * The properties of the replication lag of a namespace migration for a single target.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The service does not expose a provisioning state for this read-only proxy resource."
@added(Versions.v2026_09_01_preview)
model NamespaceMigrationReplicationLagProperties {
  /**
   * The descriptions of the counters reported in the replication lag.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  counterDescriptions?: ReplicationLagCounter[];

  /**
   * The counter values aggregated at the target level.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["counterName"])
  values?: ReplicaLagValue[];

  /**
   * Further breakdowns of the replication lag for the target.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  breakdowns?: ReplicaLagInfo[];
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "A migration is stopped with the terminate action; the singleton resource itself cannot be deleted."
@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface NamespaceMigrations {
  /**
   * Gets the current status of a namespace migration.
   */
  get is ArmResourceRead<NamespaceMigration, Error = ErrorResponse>;

  /**
   * Triggers a migration of the namespace to a new SKU across the specified target locations.
   */
  @action("triggerMigration")
  triggerMigration is ArmResourceActionNoResponseContentAsync<
    EHNamespace,
    NamespaceMigrationConfiguration,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * Terminates an in-progress namespace migration.
   */
  @action("terminateMigration")
  terminateMigration is ArmResourceActionNoResponseContentAsync<
    EHNamespace,
    void,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface NamespaceMigrationReplicationLags {
  /**
   * Lists the replication lags for an in-progress namespace migration.
   */
  list is ArmResourceListByParent<
    NamespaceMigrationReplicationLag,
    Error = ErrorResponse
  >;
}

@@doc(NamespaceMigration.name, "The migration resource name. Must be 'default'.");
@@doc(NamespaceMigration.properties, "The properties of the namespace migration.");
@@doc(NamespaceMigrationReplicationLag.name,
  "The name of the migration target the replication lag is reported for."
);
@@doc(NamespaceMigrationReplicationLag.properties,
  "The properties of the replication lag."
);
@@doc(
  NamespaceMigrations.triggerMigration::parameters.body,
  "Parameters that describe the target SKU and locations for the namespace migration."
);
@@clientName(NamespaceMigrations.triggerMigration::parameters.body,
  "parameters"
);
