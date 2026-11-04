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
  @action("trigger")
  trigger is ArmResourceActionNoResponseContentAsync<
    NamespaceMigration,
    NamespaceMigrationConfiguration,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * Terminates an in-progress namespace migration.
   */
  @action("terminate")
  terminate is ArmResourceActionNoResponseContentAsync<
    NamespaceMigration,
    void,
    LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * Gets the replication lags for an in-progress namespace migration.
   */
  @action("getReplicationLags")
  getReplicationLags is ArmResourceActionSync<
    NamespaceMigration,
    void,
    ArmResponse<NamespaceMigrationReplicationLags>,
    Error = ErrorResponse
  >;
}

@@doc(NamespaceMigration.name, "The migration resource name. Must be 'default'.");
@@doc(NamespaceMigration.properties, "The properties of the namespace migration.");
@@doc(
  NamespaceMigrations.trigger::parameters.body,
  "Parameters that describe the target SKU and locations for the namespace migration."
);
@@clientName(NamespaceMigrations.trigger::parameters.body, "parameters");
