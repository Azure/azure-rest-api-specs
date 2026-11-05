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
 * The properties of a namespace migration.
 */
@added(Versions.v2026_09_01_preview)
model NamespaceMigrationProperties {
  /**
   * The migration settings.
   */
  migration?: NamespaceMigrationDetails;
}

/**
 * The status of a namespace migration.
 */
@added(Versions.v2026_09_01_preview)
model NamespaceMigrationStatus {
  /**
   * The properties of the namespace migration.
   */
  properties?: NamespaceMigrationProperties;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface NamespaceMigrations {
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

  /**
   * Gets the current status of a namespace migration.
   */
  @get
  @action("migrationStatus")
  getMigrationStatus is ArmResourceActionSync<
    EHNamespace,
    void,
    ArmResponse<NamespaceMigrationStatus>,
    Error = ErrorResponse
  >;

  /**
   * Gets the replication lags for an in-progress namespace migration.
   */
  @get
  @action("migrationReplicationLags")
  getMigrationReplicationLags is ArmResourceActionSync<
    EHNamespace,
    void,
    ArmResponse<NamespaceMigrationReplicationLags>,
    Error = ErrorResponse
  >;
}

@@doc(
  NamespaceMigrations.triggerMigration::parameters.body,
  "Parameters that describe the target SKU and locations for the namespace migration."
);
@@clientName(NamespaceMigrations.triggerMigration::parameters.body,
  "parameters"
);
